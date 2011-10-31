From: rajeshwari.birje@gmail.com (Rajeshwari Birje)
Date: Mon, 31 Oct 2011 09:52:41 +0530
Subject: [PATCH V5 1/3] SDHCI: S3C: Use generic clock names for sdhci bus
	clock options
In-Reply-To: <m2obx34j81.fsf@bob.laptop.org>
References: <1318588126-19167-1-git-send-email-rajeshwari.s@samsung.com>
	<1318588126-19167-2-git-send-email-rajeshwari.s@samsung.com>
	<m2obx34j81.fsf@bob.laptop.org>
Message-ID: <CAPs=JDentx5BMfT4JYxSUpdQqKveAVMcJZk_TAatEwSoLDHUTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,

Thank you for your comment will modify and resend the patches.

Regards,
Rajeshwari Shinde.

On Thu, Oct 27, 2011 at 1:29 AM, Chris Ball <cjb@laptop.org> wrote:
> Hi Rajeshwari, Kukjin,
>
> On Fri, Oct 14 2011, Rajeshwari Shinde wrote:
>> This patch modifies the driver to stop depending on the clock names
>> being passed from the platform and switch over to bus clock lookup
>> using generic clock names.
>>
>> Signed-off-by: Rajeshwari Shinde <rajeshwari.s@samsung.com>
>> ---
>> ?drivers/mmc/host/sdhci-s3c.c | ? ?6 ++----
>> ?1 files changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
>> index 82709b6..a5fde87 100644
>> --- a/drivers/mmc/host/sdhci-s3c.c
>> +++ b/drivers/mmc/host/sdhci-s3c.c
>> @@ -435,14 +435,12 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
>>
>> ? ? ? for (clks = 0, ptr = 0; ptr < MAX_BUS_CLK; ptr++) {
>> ? ? ? ? ? ? ? struct clk *clk;
>> - ? ? ? ? ? ? char *name = pdata->clocks[ptr];
>> + ? ? ? ? ? ? char name[14];
>>
>> - ? ? ? ? ? ? if (name == NULL)
>> - ? ? ? ? ? ? ? ? ? ? continue;
>> + ? ? ? ? ? ? sprintf(name, "mmc_busclk.%d", ptr);
>
> Let's use snprintf() here instead -- it's better to have fewer uses of
> sprintf() to audit.
>
>> ? ? ? ? ? ? ? clk = clk_get(dev, name);
>> ? ? ? ? ? ? ? if (IS_ERR(clk)) {
>> - ? ? ? ? ? ? ? ? ? ? dev_err(dev, "failed to get clock %s\n", name);
>> ? ? ? ? ? ? ? ? ? ? ? continue;
>> ? ? ? ? ? ? ? }
>
> Thanks,
>
> - Chris.
> --
> Chris Ball ? <cjb@laptop.org> ? <http://printf.net/>
> One Laptop Per Child
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
