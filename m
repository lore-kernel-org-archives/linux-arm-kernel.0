From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 24 Mar 2015 08:16:10 +1100
Subject: linux-next: manual merge of the arm-soc tree with the arm-perf
 tree
In-Reply-To: <55102DAF.7050206@arm.com>
References: <20150323113318.0319c248@canb.auug.org.au>
 <CAM4voanC-ur=A-UJ+Jw4qECUOnd-gZ2V87794tEVWJOqaqDT+g@mail.gmail.com>
 <55102DAF.7050206@arm.com>
Message-ID: <20150324081610.52b1e92d@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

On Mon, 23 Mar 2015 15:13:51 +0000 "Suzuki K. Poulose" <Suzuki.Poulose@arm.com> wrote:
>
> On 23/03/15 14:41, Abhilash Kesavan wrote:
> >
> > On Mon, Mar 23, 2015 at 6:03 AM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >>
> >> Today's linux-next merge of the arm-soc tree got a conflict in
> >> drivers/bus/Kconfig between commit c9966c98697a ("arm-cci: Split the
> >> code for PMU vs driver support") from the arm-perf tree and commit
> >> 13fbf3c8d0f7 ("drivers: bus: Sort Kconfig entries alphabetically") from
> >> the arm-soc tree.
> >>
> >> I fixed it up (see below) and can carry the fix as necessary (no action
> >> is required).
> >
> > Not sure if this has been reported elsewhere, but I am seeing core
> > boot-up failures on the exynos5420 with next-20150323 due to this.
> > Your conflict fix is missing the ARM_CCI symbol because of which the
> > CCI does not get enabled.
> >
> > Suzuki, can you confirm ?
> 
> Yes, you are right. We need the config ARM_CCI even now, which enables 
> the building of the arm-cci.c.
> 
> Stephen,
> 
> We need the following fix on the linux-next.

Oops, sorry about that.  I have fixed up the merge resolution for today
so that file starts like this:

#
# Bus Devices
#

menu "Bus devices"

config ARM_CCI
	bool

config ARM_CCI400_COMMON
	bool
	select ARM_CCI

config ARM_CCI400_PMU
	bool "ARM CCI400 PMU support"
	default y
	depends on ARM || ARM64
	depends on HW_PERF_EVENTS
	select ARM_CCI400_COMMON
	help
	  Support for PMU events monitoring on the ARM CCI cache coherent
	  interconnect.

	  If unsure, say Y

config ARM_CCI400_PORT_CTRL
	bool
	depends on ARM && OF && CPU_V7
	select ARM_CCI400_COMMON
	help
	  Low level power management driver for CCI400 cache coherent
	  interconnect for ARM platforms.

config ARM_CCN
	.
	.
	.
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150324/85e23faa/attachment-0001.sig>
