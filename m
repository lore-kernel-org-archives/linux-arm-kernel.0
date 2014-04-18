From: manabian@gmail.com (Joachim Eastwood)
Date: Fri, 18 Apr 2014 20:03:56 +0200
Subject: [PATCH 1/4] ARM: dts: Add support for OMAP4 Variscite OM44 family
In-Reply-To: <20140418172907.GK5354@atomide.com>
References: <1397833849-22396-1-git-send-email-manabian@gmail.com>
 <1397833849-22396-2-git-send-email-manabian@gmail.com>
 <20140418155721.GC5354@atomide.com>
 <CAGhQ9VysdxGMd99CiVVh8YJt7KDAyy3Pe9YA2VM-G4mzn_6+0g@mail.gmail.com>
 <20140418172907.GK5354@atomide.com>
Message-ID: <CAGhQ9VyFU0ee3nXmD3Ckpaj1wYfgWXWG1k=L16MYCX05sCtjOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 April 2014 19:29, Tony Lindgren <tony@atomide.com> wrote:
> * Joachim Eastwood <manabian@gmail.com> [140418 09:18]:
>> On 18 April 2014 17:57, Tony Lindgren <tony@atomide.com> wrote:
>> > * Joachim Eastwood <manabian@gmail.com> [140418 08:11]:
>> >> Add support for VAR-SOM-OM44[1] SODIMM system on module from Variscite. SoM
>> >> features a OMAP4460, 1GB RAM, Gigabit Ethernet (LAN7500) and optional WLAN/BT.
>> >>
>> >> Also add support for VAR-STK-OM44 development board from Variscite. This kit
>> >> features a VAR-SOM-OM44 and the carrier board VAR-OM44CustomBoard[2]. The
>> >> VAR-STK-OM44 is the same as VAR-DVK-OM44 but without the LCD display.
>> >>
>> >> omap4-var-stk-om44.dts replace the old and very limited omap4-var-som.dts.
>> >>
>> >> [1] http://www.variscite.com/products/system-on-module-som/cortex-a9/var-som-om44-cpu-ti-omap-4-omap4460
>> >> [2] http://www.variscite.com/products/single-board-computers/var-om44customboard
>> >>
>> >> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
>> >> ---
>> >>  .../devicetree/bindings/arm/omap/omap.txt          |   3 +
>> >>  .../devicetree/bindings/vendor-prefixes.txt        |   1 +
>> >>  arch/arm/boot/dts/Makefile                         |   2 +-
>> >>  arch/arm/boot/dts/omap4-var-om44customboard.dtsi   | 235 ++++++++++++++
>> >>  arch/arm/boot/dts/omap4-var-som-om44.dtsi          | 343 +++++++++++++++++++++
>> >>  arch/arm/boot/dts/omap4-var-som.dts                |  96 ------
>> >>  arch/arm/boot/dts/omap4-var-stk-om44.dts           |  16 +
>> >>  7 files changed, 599 insertions(+), 97 deletions(-)
>> >>  create mode 100644 arch/arm/boot/dts/omap4-var-om44customboard.dtsi
>> >>  create mode 100644 arch/arm/boot/dts/omap4-var-som-om44.dtsi
>> >>  delete mode 100644 arch/arm/boot/dts/omap4-var-som.dts
>> >>  create mode 100644 arch/arm/boot/dts/omap4-var-stk-om44.dts
>> >
>> > Hmm don't you still need to keep omap4-var-som.dts to build just the
>> > core SoC module without any add-on boards?
>>
>> Since VAR-SOM-OM44 is a SODIMM module it is not possible to use
>> without a carrier board. Variscite's carrier board is called
>> OM44CustomBoard and I am in process of creating my own application
>> specific one so the omap4-var-som-om44 should be a dtsi-file.
>
> OK, thanks for clarifying that.
>
>> > Also, you might want to use the OMAP4_CORE_IOPAD and OMAP4_WKUP_IOPAD
>> > macros in include/dt-bindings/pinctrl/omap.h to be able to check the
>> > registers against the TRM easier as you can use the physical register
>> > offset listed in the TRM.
>>
>> I don't see any other OMAP4 using these macros. Is there a plan for a
>> mass conversion?
>
> Makes sense to do while doing other clean-up to avoid extra churn,
> but no mass conversion planned so far.
>
>> It's really a job for an automated script. But the macro are indeed
>> nice. That offset has bothered me more than once.
>
> Yeah and we can also add some range checking to the OMAP_IOPAD_OFFSET
> macro eventually :)

I see.

> I did a check script when we split omap3 pinctrl core instance into
> two separate instance to deal with the large hole in the register
> space. Some parts of that might be usable for a generic conversion
> script too. The script I used is below for reference.

I hacked up a short awk-script for the job. So I'll change to IOPAD
macro's in the next version.

My script for reference :)
#!/bin/gawk -f
/omap4_pmx_core/ { pmx = "CORE" }
/omap4_pmx_wkup/ { pmx = "WKUP" }
/0x[0-9a-f]{1,3} \(PIN/ {
offset = sprintf("OMAP4_%s_IOPAD(0x%03x, ", pmx, strtonum($1) + 64)
sub(/0x[0-9a-f]{1,3} \(/, offset, $0)
print $0
next
}
{ print $0 }

I'll wait a bit with v2 to see if there are any other comments. Would
be nice to get clarification on the display bindings also.

regards
Joachim Eastwood
