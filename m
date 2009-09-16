From: jassisinghbrar@gmail.com (jassi brar)
Date: Wed, 16 Sep 2009 10:37:09 +0900
Subject: [PATCH 03/10] S3C64XX I2S: Codec Clock Gating Option
In-Reply-To: <20090915104417.GF22878@rakim.wolfsonmicro.main>
References: <1253008955-10505-1-git-send-email-jassi.brar@samsung.com>
	<20090915104417.GF22878@rakim.wolfsonmicro.main>
Message-ID: <1b68c6790909151837x35cc7171y42c6a612975052ee@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 15, 2009 at 7:44 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Sep 15, 2009 at 07:02:35PM +0900, Jassi wrote:
>> In SoC-Master mode, CODCLK maybe gated out as MCLK of the CODEC.
>> In SoC-Slave mode, CODCLK needs to be cut-off from PAD inorder
>> to avoid collision with MCLK from CODEC.
>> Option to gate/block CODCLK is implemented in this patch.

> In terms of functionality it might be clearer to describe what's going
> on here as switching the function of CDCLK from being an input to being
> an output. ?The actual implementation appears to be done by gating the
> output of the internal clock signal to the CDCLK pin but in terms of
> what the user can see externally the clock isn't gated, it's still
> active but it changed direction.
The bit IISMOD[12], if cleared, gates the RCLK towards  the Xi2sCDCLK.
If this bit is set, it simply disconnects the RCLK and Xi2sCDCLK.

If the I2S controller wants to use clock from Xi2sCDCLK via
"audio-bus" through the MUX, then we want RCLK to be disconnected and
we set this bit 1.
If we provide the MCLK of the CODEC from RCLK of I2S controller, we
connect RCLK to Xi2sCDCLK which is usually connected to the MCLK of
the CODEC, In this case we gate RCLK by clearing this bit (note that
it is a not-gate)

>> +#define S3C64XX_IISMOD_CDCLK_EXT ? ? (1 << 12)
>> +
>
> The datasheet calls this bit CDLKCON - it'd be better to preserve that
> naming unless there is a good reason to diverge?
CON is better used for register defines.
This is but one bit: CodecClock is Internal or External.
So, yes, minor but some reason for that.
Btw, I have already notified this issue to our technical writers.

>> @@ -99,6 +99,14 @@ static int s3c64xx_i2s_set_sysclk(struct snd_soc_dai *cpu_dai,
>> ? ? ? ? ? ? ? iismod |= S3C64XX_IISMOD_IMS_SYSMUX;
>> ? ? ? ? ? ? ? break;
>>
>> + ? ? case S3C64XX_CODCLKSRC_INT:
>> + ? ? ? ? ? ? iismod &= ~S3C64XX_IISMOD_CDCLK_EXT;
>> + ? ? ? ? ? ? break;
>> +
>> + ? ? case S3C64XX_CODCLKSRC_EXT:
>> + ? ? ? ? ? ? iismod |= S3C64XX_IISMOD_CDCLK_EXT;
>> + ? ? ? ? ? ? break;
>> +
>
> This should really be done using the direction parameter - clk_id should
> specify that CDCLK should be used and the direction parameter be used to
> say if it's an input or output.
Again, the patch aims to simply fit in the place. For the current
state and design of our driver this change is least intrusive and most
simple.
