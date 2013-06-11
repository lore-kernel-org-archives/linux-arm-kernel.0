From: ttynkkynen@nvidia.com (Tuomas Tynkkynen)
Date: Tue, 11 Jun 2013 13:09:39 +0300
Subject: [PATCH 1/2] memory: tegra20-mc: Fix hang in IRQ handler.
In-Reply-To: <20130610203641.GA26036@mithrandir>
References: <1370855624-30564-1-git-send-email-ttynkkynen@nvidia.com>
 <1370855624-30564-2-git-send-email-ttynkkynen@nvidia.com>
 <20130610203641.GA26036@mithrandir>
Message-ID: <51B6F763.2080004@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/10/2013 11:36 PM, Thierry Reding wrote:
> On Mon, Jun 10, 2013 at 12:13:43PM +0300, Tuomas Tynkkynen wrote:
>> In Tegra20 memory controller any MC interrupt would cause an
>> infinite loop in the IRQ handler.
>>
>> Signed-off-by: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
>> ---
>>  drivers/memory/tegra20-mc.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/memory/tegra20-mc.c b/drivers/memory/tegra20-mc.c
>> index 2ca5f28..bd5a553 100644
>> --- a/drivers/memory/tegra20-mc.c
>> +++ b/drivers/memory/tegra20-mc.c
>> @@ -193,8 +193,11 @@ static irqreturn_t tegra20_mc_isr(int irq, void *data)
>>  	mask &= stat;
>>  	if (!mask)
>>  		return IRQ_NONE;
>> -	while ((bit = ffs(mask)) != 0)
>> +	while ((bit = ffs(mask)) != 0) {
>>  		tegra20_mc_decode(mc, bit - 1);
>> +		mask &= BIT(bit);
> 
> Shouldn't this be "mask &= ~BIT(bit);"? The intent of the code is to
> clear the bit which was handled by the loop body, right? The above
> clears all other bits instead.
> 
> Thierry

Whoops, yes it should be clearing just one bit. And since ffs() returned
a one-based bit-index, it seemed to work in practice.

I'll fix those & resend.

- Tuomas
