From: panand@redhat.com (Pratyush Anand)
Date: Mon, 4 Jul 2016 15:45:56 +0530
Subject: [PATCH v20 00/14] arm64 kexec kernel patches
In-Reply-To: <20160704071408.GP20774@linaro.org>
References: <cover.1466702804.git.geoff@infradead.org>
 <20160627170039.GD6847@e104818-lin.cambridge.arm.com>
 <20160629005414.GC20774@linaro.org>
 <20160629092049.GA2522@e104818-lin.cambridge.arm.com>
 <20160630014603.GK20774@linaro.org>
 <20160701023957.GC20766@dhcppc9>
 <20160704071408.GP20774@linaro.org>
Message-ID: <20160704101556.GA11075@dhcppc9>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/07/2016:04:14:09 PM, AKASHI Takahiro wrote:
> On Fri, Jul 01, 2016 at 08:09:57AM +0530, Pratyush Anand wrote:
> > Hi Takahiro,
> > 
> > On 30/06/2016:10:46:04 AM, AKASHI Takahiro wrote:
> > > On Wed, Jun 29, 2016 at 10:20:50AM +0100, Catalin Marinas wrote:
> > > > On Wed, Jun 29, 2016 at 09:54:15AM +0900, AKASHI Takahiro wrote:
> > > > > On Mon, Jun 27, 2016 at 06:00:39PM +0100, Catalin Marinas wrote:
> > > > > > On Thu, Jun 23, 2016 at 05:54:47PM +0000, Geoff Levand wrote:
> > > > > > > AKASHI Takahiro (7):
> > > > > > >       arm64: kdump: reserve memory for crash dump kernel
> > > > > > >       arm64: limit memory regions based on DT property, usable-memory
> > > > > > >       arm64: kdump: implement machine_crash_shutdown()
> > > > > > >       arm64: kdump: add kdump support
> > > > > > >       arm64: kdump: add VMCOREINFO's for user-space coredump tools
> > > > > > >       arm64: kdump: enable kdump in the arm64 defconfig
> > > > > > >       arm64: kdump: update a kernel doc
> > > > > > > 
> > > > > > > Geoff Levand (4):
> > > > > > >       arm64: Add back cpu reset routines
> > > > > > >       arm64/kexec: Add core kexec support
> > > > > > >       arm64/kexec: Enable kexec in the arm64 defconfig
> > > > > > >       arm64/kexec: Add pr_debug output
> > > > > > > 
> > > > > > > James Morse (3):
> > > > > > >       arm64: hibernate: Don't hibernate on systems with stuck CPUs
> > > > > > >       arm64: smp: Add function to determine if cpus are stuck in the kernel
> > > > > > >       Documentation: dt: usable-memory and elfcorehdr nodes for arm64 kexec
> > > > > > 
> > > > > > I dropped patch 1 (hibernate), cherry-picked patch 2 from mainline
> > > > > > ("cpus stuck in the kernel", already pushed by Will to 4.7-rc5) and
> > > > > > merged patches 3-6, with the amendments that James mentioned.
> > > > > > 
> > > > > > The kdump patches, including the "Documentation" one from James require
> > > > > > more review, testing and acks by the corresponding maintainers (kdump,
> > > > > > DT).
> > > > > 
> > > > > I see what you mean, but even for Geoff's kexec part, the maintainer
> > > > > (Eric) have not given his ack.
> > > > 
> > > > I just assumed he won't object ;). The only generic change is the
> > > > KEXEC_ARCH_AARCH64 in the uapi/linux/kexec.h file and the value chosen
> > > > matches EM_AARCH64.
> > > > 
> > > > The kdump patches make such changes to Documentation and I would like
> > > > those acked by the kdump and DT maintainers.
> > > 
> > > OK, I asked the corresponding maintainers to review them.
> > > 
> > > > Pratyush Anand also had comments on the kdump patches in v19, so it's
> > > > fair to wait for him to complete the reviewing of the latest series.
> > > 
> > > I think that it was my mistake that I referred to makedumpfile-related
> > > VMCOREINFO's in my patch.
> > > Since I'm not a user nor author of makedumpfile command for arm64,
> > > my changes should have been minimized, exluding any non-mandatory symbols.
> > > (Patch#13/14 is necessary for me to verify generated vmcore files
> > > with crash utility.)
> > > So I asked Pratyush to post his kernel patch based on his own requirements
> > > as he wants.
> > > I believe it's fair enough.
> > 
> > Sorry for delayed response.
> > I am agreeing to this patchset. makedumpfile would also be able to work by
> > directly reading page table entries for all virtual addresses.
> 
> So are you going to add a physical address of swapper_pg_dir?

NO, I think, I can take it for-granted that swapper_pg_dir will always lie in
identity mapped region. So, I will use __pa() macro only to translate
swapper_pg_dir.  Rest all virtual addresses will be translated using page table
entries.

> Do you see any visible speed down of makedumpfile?

I will take back my comment here. Its almost negligible. About 2 Sec slower when
whole dump process took around 2m 44 S.

~Pratyush
