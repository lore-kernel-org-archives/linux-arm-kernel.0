From: joel.schopp@amd.com (Joel Schopp)
Date: Wed, 25 Jun 2014 14:34:51 -0500
Subject: [PATCH v2 9/9] arm64: KVM: vgic: deal with GIC sub-page alignment
In-Reply-To: <CAFEAcA-5CaE6T2JkNdf7M9t3LTqv05Um-nWbWjSDVbu_Bo+a2w@mail.gmail.com>
References: <1403169693-13982-1-git-send-email-marc.zyngier@arm.com>
 <1403169693-13982-10-git-send-email-marc.zyngier@arm.com>
 <53A9D14D.2020802@amd.com>
 <CAFEAcA-8vOz34NPPqkh1trU5C1irGatcJjAr1f-wWEPzhpy95w@mail.gmail.com>
 <53AAE31C.2060506@amd.com>
 <CAFEAcA-5CaE6T2JkNdf7M9t3LTqv05Um-nWbWjSDVbu_Bo+a2w@mail.gmail.com>
Message-ID: <53AB245B.8080409@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 06/25/2014 12:34 PM, Peter Maydell wrote:
> On 25 June 2014 15:56, Joel Schopp <joel.schopp@amd.com> wrote:
>> On 06/24/2014 05:28 PM, Peter Maydell wrote:
>>> On 24 June 2014 20:28, Joel Schopp <joel.schopp@amd.com> wrote:
>>>> Does this mean there is a corresponding patch for qemu?
>>> Not as far as I know. It's a bit awkward on the QEMU end because
>>> we really want to provide the guest a consistent memory map
>>> regardless of the host CPU. So at best we'd probably use it to
>>> say "sorry, can't run on this CPU/host kernel".
>> I think most arm64 servers are going to run with 64k pages.  It seems like a
>> major problem to have qemu not work on these systems.
> QEMU should already work fine on servers with 64K pages;
> you just need to have the host offset of the GICV within the 64K page
> and the guest offset of the GICC within the 64K page be the same
> (and at the moment both must also be zero, which I believe is true
> for all of them at the moment except possibly the AEM model;
> counterexamples welcome). Disclaimer: I haven't personally
> tested this, but on the other hand I don't think anybody's
> reported it as not working either.

It doesn't work for me.  Maybe I'm doing something wrong, but I can't 
see what.  I am unique in that I'm running a gic-400 (gicv2m) on aarch64 
hardware with 64k pages.  I'm also unique in that my hardware maps each 
4K gic entry to a 64K page (aliasing each 4k of gic 16 times in a 64K 
page, ie the gic virtual ic is at 0xe1140000 and 0xe1141000 and 
0xe1142000, etc).  This is inline with appendix F of the server base 
system architecture.  This is inconvenient when the size is 0x2000 
(8K).  As a result all the offsets in the device tree entries are to the 
last 4K in the page so that an 8K read will read the last 4k from one 
page and the first 4k from the next and actually get 8k of the gic.


         gic: interrupt-controller at e1101000 {
                 compatible = "arm,gic-400";
                 #interrupt-cells = <3>;
                 #address-cells = <0>;
                 interrupt-controller;
                 msi-controller;
                 reg = <0x0 0xe1110000 0 0x1000>, /* gic dist */
                       <0x0 0xe112f000 0 0x2000>, /* gic cpu */
                       <0x0 0xe114f000 0 0x2000>, /* gic virtual ic*/
                       <0x0 0xe116f000 0 0x2000>, /* gic virtual cpu*/
                       <0x0 0xe1180000 0 0x1000>; /* gic msi */

                 interrupts = <1 8 0xf04>;
         };


My concern here is that if userspace is going to look at 8k starting at 
the beginning of the page, guest offset 0 in your terminology, (say 
0xe1140000) instead of starting at the last 4k of the page, offset 
0xf000 (say 0xe114f000) it is going to get the second 4k wrong by 
reading 0xe1141000 instead of 0xe1150000.
