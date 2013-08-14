From: dsd@laptop.org (Daniel Drake)
Date: Wed, 14 Aug 2013 15:25:32 -0600
Subject: [PATCH v6 09/11] clk: mmp: parse clock from dts
In-Reply-To: <CAN1soZxwgNf_URTs8dg152jWuspuHRiLZGad7GPdJ46QGXqu1A@mail.gmail.com>
References: <1374833133-21119-1-git-send-email-haojian.zhuang@gmail.com>
 <1374833133-21119-10-git-send-email-haojian.zhuang@gmail.com>
 <CAMLZHHRwW9fodM4poVL=OK47NU2-_PCfpHHfM2crBMefw+Uy2A@mail.gmail.com>
 <CAN1soZxwgNf_URTs8dg152jWuspuHRiLZGad7GPdJ46QGXqu1A@mail.gmail.com>
Message-ID: <CAMLZHHSO9UrBRhTrYHsTHte66AB-pdDfc3vPNVmxeZx9biCBkA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 10, 2013 at 11:22 PM, Haojian Zhuang
<haojian.zhuang@gmail.com> wrote:
>> I see that your implementation here moves away from using the existing
>> code in clk-apmu.c and instead just uses clk-divider directly. That
>> might make sense, but your new DTS does not reimplement many of the
>> static APMU clocks that were previously implemented (e.g. ccic, sdh in
>> clk-mmp2.c). Why is this?
>>
> I'll append them later.

Looking closer I see that you only implemented this for pxa910 - and
(as noted above) you only reimplemented a subset of the clocks.

The original static clock code is still in place and being called
(pxa910_init calls pxa910_clk_init). This will result in some of the
clocks being duplicated (defined once in DT and again in static code).
I think you should either add a mechanism to avoid doing both (e.g.
see the end of http://lists.infradead.org/pipermail/linux-arm-kernel/2013-June/177153.html)
or simply remove support for non-DT clocks (depending on user base,
not sure if this is possible).

I think adding support for all the clocks in DT now is quite important
as I suspect it will change your DT design. Your patch treats APMU
clocks always as simple dividers or muxes, always enabled, however I
don't think it is possible to represent the SDH/display APMU clocks in
this way, at least I have not found a way to do it. These clocks are
in reset by default and certain bits must be written to enable them.

Finally there is something confusing in mmp_apbc_setup()

+       if (of_property_read_string(np, "clock-names", &clk_name))
+               clkdev = 1;
+       else {
+               of_property_read_string(np, "clock-output-names", &clk_name);
+               clkdev = 0;
+       }
+       if (clkdev)
+               clk_register_clkdev(clk, clk_name, NULL);

Can you explain what this logic is trying to do?
I think it is wrong. If I provide the name for the clock I want to
output from my provider, I do not get registered? And in order for me
to get my clock provider registered, I have to provide a clock-names
property which is then used to name the device?? But clock-names is
usually used for the input clock name. And I don't see why providing a
name is necessary, it could just use node->name.

Thanks
Daniel
