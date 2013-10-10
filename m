From: monstr@monstr.eu (Michal Simek)
Date: Thu, 10 Oct 2013 07:21:40 +0200
Subject: [PATCH 1/2] clk/zynq/clkc: Add 'fclk-enable' feature
In-Reply-To: <fe3858e7-e3e2-4806-aeca-a2a4676e09aa@CO1EHSMHS007.ehs.local>
References: <1381242972-14752-1-git-send-email-soren.brinkmann@xilinx.com>
 <20131008153816.GB4981@e106331-lin.cambridge.arm.com>
 <fe3858e7-e3e2-4806-aeca-a2a4676e09aa@CO1EHSMHS007.ehs.local>
Message-ID: <52563964.4030905@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/09/2013 05:25 PM, S?ren Brinkmann wrote:
> On Tue, Oct 08, 2013 at 04:38:17PM +0100, Mark Rutland wrote:
>> On Tue, Oct 08, 2013 at 03:36:11PM +0100, Soren Brinkmann wrote:
>>> In some use cases Zynq's FPGA clocks are used as static clock
>>> generators for IP in the FPGA part of the SOC for which no Linux driver
>>> exists and would control those clocks. To avoid automatic
>>> gating of these clocks in such cases a new property - fclk-enable - is
>>> added to the clock controller's DT description to accomodate such use
>>> cases. It's value is a bitmask, where a set bit results in enabling
>>> the corresponding FCLK through the clkc.
>>>
>>> FPGA clocks are handled following the rules below:
>>>
>>> If an FCLK is not enabled by bootloaders, that FCLK will be disabled in
>>> Linux. Drivers can enable and control it through the CCF as usual.
>>>
>>> If an FCLK is enabled by bootloaders AND the corresponding bit in the
>>> 'fclk-enable' DT property is set, that FCLK will be enabled by the clkc,
>>> resulting in an off by one reference count for that clock. Ensuring it
>>> will always be running.
>>>
>>> The default value for 'fclk-enable' is '0xf' (all FCLK's enabled by the
>>> bootloader are enabled through the clkc.
>>
>> Why? Juding by the diff that's not what the code currently does, so why
>> not leave it as 0, and only set it where required as a work-around?
> The default is set as described here:
> [...]
>>> +	ret = of_property_read_u32(np, "fclk-enable", &fclk_enable);
>>> +	if (ret)
>>> +		fclk_enable = 0xf;
>>> +
> 
> The default has been chosen this way, because it avoids trouble with
> customers. Customers expect the FPGA clocks to be running, once they
> configured them in the FPGA tools. If Linux gates them off for some
> reason, it creates confusion and often ends up in customer support.
> But in general I agree. It is kind of a work around and having zero as
> default would be desirable. I'd leave this to Michal.

No problem to have default value setup to 0. And use this workaround
when it is set in DTS.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131010/682a7dd9/attachment.sig>
