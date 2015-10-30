From: computersforpeace@gmail.com (Brian Norris)
Date: Fri, 30 Oct 2015 11:49:07 -0700
Subject: [PATCH v3 2/2] arm64: dts: Add BRCM IPROC NAND DT node for NS2
In-Reply-To: <5630F2E2.8060508@broadcom.com>
References: <1445577373-21252-1-git-send-email-anup.patel@broadcom.com>
 <1445577373-21252-3-git-send-email-anup.patel@broadcom.com>
 <20151028001920.GY13239@google.com> <563015FC.9040006@broadcom.com>
 <20151028003935.GZ13239@google.com> <56301B00.1020301@broadcom.com>
 <39063E8F96E11742B35A201CC5D095B7AFFB81@SJEXCHMB10.corp.ad.broadcom.com>
 <5630F2E2.8060508@broadcom.com>
Message-ID: <20151030184907.GH13239@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 28, 2015 at 09:08:02AM -0700, Ray Jui wrote:
> On 10/28/2015 2:06 AM, Anup Patel wrote:
> >
> >I think for a newly created OF devices the Linux device driver framework will
> >match the platform drivers in the order in which they are registered by module
> >init functions. Now the order of module init function calls will be based how
> >the .initcall section is formed by linker and order in which objects are linked.
> >
> 
> Yes, what you said is my understanding as well, but then here is the
> mystery. This is the link order in brcmnand/Makefile:
> 
> 1 # link order matters; don't link the more generic brcmstb_nand.o
> before the
> 2 # more specific iproc_nand.o, for instance
> 3 obj-$(CONFIG_MTD_NAND_BRCMNAND) += iproc_nand.o
> 4 obj-$(CONFIG_MTD_NAND_BRCMNAND) += bcm63138_nand.o
> 5 obj-$(CONFIG_MTD_NAND_BRCMNAND) += brcmstb_nand.o
> 6 obj-$(CONFIG_MTD_NAND_BRCMNAND) += brcmnand.o
> 
> Based on the order above, probe from iproc_nand should always be
> called first if a matching compatible string is found. If so, then
> why having both compatible strings "brcm,brcmnand" and
> "brcm,nand-iproc" causes issues for NS2 (I remember it broke
> smoketest in the past when you submitted the change)? I'm not saying
> we should have "brcm,brcmnand" for iProc devices, but I don't get
> why it would cause any issue.

FWIW, the above hack doesn't do anything if these are built as modules,
AFAICT. So I guess udev's (or similar) module rules would be another
point of failure here? Not that any of us probably care too much about
this driver as a module, but just throwing it out there...

I have a feeling we'll have to solve this locally, by avoiding having
"independent" drivers handling similar compatible properties, as I
expect (despite our expectation that compatible ordering should matter)
this problem will not be solved any time soon in the generic
infrastructure.

Or we can just use a hack (as Anup is doing) to leave off the
"brcm,brcmnand" compatibility property. Unless someone has brilliant
ideas, I guess we go with Anup's hack for now.

Brian
