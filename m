From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 7 Jun 2011 11:44:01 +0800
Subject: [RFC 1/2] ARM:Tegra: Device Tree Support: Initialize the audio
	card from the device tree.
In-Reply-To: <BANLkTimavC-6oMhAHHsBJ2_Em7aXi7eyNQ@mail.gmail.com>
References: <20110527205444.21000.90209.stgit@riker>
	<20110527205706.21000.34832.stgit@riker>
	<BANLkTi=NMjBjWVv_o3PocejhgGr8TdG+1Q@mail.gmail.com>
	<BANLkTi=PtEhxxmZo2DqvmySCmnEd3LbezQ@mail.gmail.com>
	<BANLkTikWpiY_o27OF-Jxvq7iPeWzrAYOsQ@mail.gmail.com>
	<20110602160445.GA8373@ponder.secretlab.ca>
	<20110602213656.GB10532@n2100.arm.linux.org.uk>
	<BANLkTimavC-6oMhAHHsBJ2_Em7aXi7eyNQ@mail.gmail.com>
Message-ID: <BANLkTik=Drbr4dQMYE3VLcjuxe+fZ--6RQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/6/3 Barry Song <21cnbao@gmail.com>:
> 2011/6/3 Russell King - ARM Linux <linux@arm.linux.org.uk>:
>> On Thu, Jun 02, 2011 at 10:04:45AM -0600, Grant Likely wrote:
>>> Right now we can't do dynamic registration for on-chip devices in a
>>> lot of cases because we don't have the infrastructure to hook up the
>>> associated struct clks.
>>
>> I've been wondering about this, and I don't see it as a blocking problem
>> as you seem to be.
>>
>> I assume platform devices have stable names when they're created from
>> the device tree? ?If yes, there's no problem having the DT start to
>> describe the SoC specific devices _today_ - all that the clk API using
>> clkdev requires is a stable device name.
>
> when i write the following nodes in dts,
>
> uart0: uart at 0xb0060000 {
> ? ? ? ?compatible = "sirf,uart";
> ? ? ? ?...
> }
>
> uart1: uart at 0xb0050000 {
> ? ? ? ?compatible = "sirf,uart";
> ? ? ? ?...
> }
>
> uart2: uart at 0xb0070000 {
> ? ? ? ?compatible = "sirf,uart";
> ? ? ? ?...
> }
>
> then create these platform devices by of_platform_xxx things, i get
> some platform devices like the below.
>
> b0060000.uart
> b0050000.uart
> b0070000.uart
>
> so these are the "stable names" you are talking about? or something else?

if so, we will need some clk_lookup table like:

#define CLK(_clk, _devname, _conname)                   \
        {                                               \
                .clk    = &clk_##_clk,                  \
                .dev_id = _devname,                     \
                .con_id = _conname,                     \
        }

CLK(uart0,      "b0060000.uart",        NULL),
CLK(uart1,      "b0050000.uart",        NULL),
CLK(uart2,      "b0070000.uart",        NULL),

it looks not like what we want too.

>
>>
>
