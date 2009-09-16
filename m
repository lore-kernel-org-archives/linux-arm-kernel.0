From: jassisinghbrar@gmail.com (jassi brar)
Date: Wed, 16 Sep 2009 10:03:41 +0900
Subject: [PATCH 05/10] S3C I2S: lrsync function made to work with IRQs
	disabled.
In-Reply-To: <20090916001439.GD24720@trinity.fluff.org>
References: <1253008957-10569-1-git-send-email-jassi.brar@samsung.com>
	<20090916001439.GD24720@trinity.fluff.org>
Message-ID: <1b68c6790909151803t74698905o2712db68ce03ea01@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 16, 2009 at 9:14 AM, Ben Dooks <ben-linux@fluff.org> wrote:
> On Tue, Sep 15, 2009 at 07:02:37PM +0900, Jassi wrote:
>> s3c2412_snd_lrsync() maybe reached with IRQs disabled and if LRCLK
>> is dead due to improper initialization of CPU or CODEC, the system
>> gets stuck in the loop because jiffies may never get updated.
>> Implemented counter based wait mechanism for atleast the same
>> timeout period.
>>
>> Signed-Off-by: Jassi <jassi.brar@samsung.com>
>> ---
>> ?sound/soc/s3c24xx/s3c-i2s-v2.c | ? 16 ++++++++++------
>> ?1 files changed, 10 insertions(+), 6 deletions(-)
>>
>> diff --git a/sound/soc/s3c24xx/s3c-i2s-v2.c b/sound/soc/s3c24xx/s3c-i2s-v2.c
>> index aa7af0b..8865bc7 100644
>> --- a/sound/soc/s3c24xx/s3c-i2s-v2.c
>> +++ b/sound/soc/s3c24xx/s3c-i2s-v2.c
>> @@ -230,6 +230,8 @@ static void s3c2412_snd_rxctrl(struct s3c_i2sv2_info *i2s, int on)
>> ? ? ? pr_debug("%s: IIS: CON=%x MOD=%x FIC=%x\n", __func__, con, mod, fic);
>> ?}
>>
>> +#define msecs_to_loops(t) (loops_per_jiffy / 1000 * HZ * t)
>> +
>> ?/*
>> ? * Wait for the LR signal to allow synchronisation to the L/R clock
>> ? * from the codec. May only be needed for slave mode.
>> @@ -237,19 +239,21 @@ static void s3c2412_snd_rxctrl(struct s3c_i2sv2_info *i2s, int on)
>> ?static int s3c2412_snd_lrsync(struct s3c_i2sv2_info *i2s)
>> ?{
>> ? ? ? u32 iiscon;
>> - ? ? unsigned long timeout = jiffies + msecs_to_jiffies(5);
>> + ? ? unsigned long loops = msecs_to_loops(5);
>>
>> ? ? ? pr_debug("Entered %s\n", __func__);
>>
>> - ? ? while (1) {
>> + ? ? while (--loops) {
>> ? ? ? ? ? ? ? iiscon = readl(i2s->regs + S3C2412_IISCON);
>> ? ? ? ? ? ? ? if (iiscon & S3C2412_IISCON_LRINDEX)
>> ? ? ? ? ? ? ? ? ? ? ? break;
>>
>> - ? ? ? ? ? ? if (timeout < jiffies) {
>> - ? ? ? ? ? ? ? ? ? ? printk(KERN_ERR "%s: timeout\n", __func__);
>> - ? ? ? ? ? ? ? ? ? ? return -ETIMEDOUT;
>> - ? ? ? ? ? ? }
>> + ? ? ? ? ? ? cpu_relax();
>
> I don't think cpu_relax() gives a defined 'timeout' length, thus this
> loop is of a very indeterminate length of timeout.
Ofcourse the total delay is non-deterministic. Besides, there is no
hard limit on the amount of time we want to wait on lrsync. And this
non-deterministic delay comes into picture only when the I2S is
broken. It is second best option to simply hanging.
Total wait period is _atleast_ what we want, as is mentioned in the changelog.

Besides, i think we can do without the cpu_relax(), no?
