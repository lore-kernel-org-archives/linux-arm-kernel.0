From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 21 Apr 2015 14:55:52 +0100
Subject: your mail
In-Reply-To: <20150421131801.GD3996@e103592.cambridge.arm.com>
References: <CAKv+Gu9u73+YKn+aR1vk+1eNF_voC71THWRQS96jyAt4HB3BQw@mail.gmail.com>
 <20150421104634.GA3996@e103592.cambridge.arm.com>
 <CAKv+Gu-3iM2+TvAgfV91FzfgAQuZhr=beeJ8RWmmGjTChbUrtQ@mail.gmail.com>
 <20150421111042.GB3996@e103592.cambridge.arm.com>
 <20150421112420.GV12732@n2100.arm.linux.org.uk>
 <20150421125049.GW12732@n2100.arm.linux.org.uk>
 <20150421131801.GD3996@e103592.cambridge.arm.com>
Message-ID: <20150421135552.GX12732@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 21, 2015 at 02:18:03PM +0100, Dave P Martin wrote:
> On Tue, Apr 21, 2015 at 01:50:50PM +0100, Russell King - ARM Linux wrote:
> > On Tue, Apr 21, 2015 at 12:24:20PM +0100, Russell King - ARM Linux wrote:
> > > We should probably create a badr macro to complement the adr pseudo-op
> > > which incorporates the BSYM thing so make this clearer - and a comment
> > > before it.  This is really the case where BSYM should be used.
> > 
> > Something like this.  Note that I've also removed the BSYM() usage in
> > the KVM code.
> 
> Nice.  Wrapping this around adr will make the assembler check that it's
> not a cross-section reference too.

While looking at this, I've become very upset with our toolchain's
abilities.  This is with stock binutils 2.22-2.25, and Ard's suggestion
for using blx:

00000000 <secondary_startup_arm>:
   0:   fafffffe        blx     4 <secondary_startup>

00000004 <secondary_startup>:
   4:   f7ff fffe       bl      0 <__hyp_stub_install_secondary>
   8:   f3ef 8900       mrs     r9, CPSR
   c:   f089 091a       eor.w   r9, r9, #26
  10:   f019 0f1f       tst.w   r9, #31

That's fine, but now if we look at the .head.text section (I also added
an ENTRY(start) to try and solve this):

00000000 <stext>:
   0:   ffff faff                       ; <UNDEFINED> instruction: 0xfffffaff

00000004 <start>:
   4:   fffef7ff        .word   0xfffef7ff
   8:   f3ef 8900       mrs     r9, CPSR
   c:   091af089        .word   0x091af089
  10:   f019 0f1f       tst.w   r9, #31
  14:   091ff029        .word   0x091ff029
  18:   09d3f049        .word   0x09d3f049
  1c:   f049 0920       orr.w   r9, r9, #32
  20:   f449d109        .word   0xf449d109
  24:   f20f7980        .word   0xf20f7980
  28:   0e13            lsrs    r3, r2, #24
  2a:   f399            .short  0xf399
  2c:   8f00            ldrh    r0, [r0, #56]   ; 0x38
  2e:   f38e            .short  0xf38e
  30:   f3de8e30        .word   0xf3de8e30
  34:   8f00            .short  0x8f00
  36:   f389 8100       msr     CPSR_c, r9

readelf for this shows for section 5:

Section Headers:
  [Nr] Name              Type            Addr     Off    Size   ES Flg Lk Inf Al
  [ 5] .head.text        PROGBITS        00000000 000290 000254 00  AX  0   0  4
...
   Num:    Value  Size Type    Bind   Vis      Ndx Name
     4: 00000000     0 SECTION LOCAL  DEFAULT    5
     5: 00000000     0 NOTYPE  LOCAL  DEFAULT    5 $a
     6: 00000004     0 NOTYPE  LOCAL  DEFAULT    5 $t
     7: 0000002e     0 NOTYPE  LOCAL  DEFAULT    5 $d
     8: 00000036     0 NOTYPE  LOCAL  DEFAULT    5 $t
...
    65: 00000000     4 FUNC    GLOBAL DEFAULT    5 stext
    66: 00000005   122 FUNC    GLOBAL DEFAULT    5 start

One has to wonder about the toolchain when the stupid $[adt] hack seems
to be going soooo wrong.

I think I'm going to stop working on this until we have a toolchain
which behaves sensibly... when you can't get the damned thing to
disassemble for confirmation purposes, its best to leave the damned
code alone.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
