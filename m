From: jeffrey.t.kirsher@intel.com (Jeff Kirsher)
Date: Wed, 20 Jan 2016 14:44:45 -0800
Subject: [PATCH] net: i40e: avoid unused function warnings
In-Reply-To: <8814508.SjLecHrQqA@wuerfel>
References: <2806620.EpZqDlZTO3@wuerfel>
 <1453328245.2958.28.camel@intel.com> <8814508.SjLecHrQqA@wuerfel>
Message-ID: <1453329885.2958.32.camel@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-01-20 at 23:28 +0100, Arnd Bergmann wrote:
> On Wednesday 20 January 2016 14:17:25 Jeff Kirsher wrote:
> > On Wed, 2016-01-20 at 11:42 +0100, Arnd Bergmann wrote:
> > > The addition of the geneve tunnel offload code left a couple
> > > of functions unconditionally defined but empty whenever
> CONFIG_VXLAN
> > > and CONFIG_GENEVE are disabled. gcc warns about this:
> > >?
> > > i40e_main.c:7049:13: warning: 'i40e_sync_udp_filters_subtask'
> defined
> > > but not used [-Wunused-function]
> > > i40e_main.c:8516:13: warning: 'i40e_add_vxlan_port' defined but
> not
> > > used [-Wunused-function]
> > > i40e_main.c:8561:13: warning: 'i40e_del_vxlan_port' defined but
> not
> > > used [-Wunused-function]
> > > i40e_main.c:8596:13: warning: 'i40e_add_geneve_port' defined but
> not
> > > used [-Wunused-function]
> > > i40e_main.c:8643:13: warning: 'i40e_del_geneve_port' defined but
> not
> > > used [-Wunused-function]
> > >?
> > > This moves the #ifdef statements to the outside of the affected
> > > functions, which avoids the warnings.
> > >?
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > Fixes: 6a899024058d ("i40e: geneve tunnel offload support")
> > > ---
> > > This is a harmless regression against v4.4, found on ARM
> randconfig
> > > builds
> >?
> > Thanks Arnd, I already have a patch from Eric Dumazet and Alex
> Duyck to
> > resolve this issue.
> >?
> > Dave- I plan on pushing the fix later today to net.
> 
> Ok, thanks.
> 
> FWIW, I have another patch for this driver that I did not yet submit
> because it's not a regression and I haven't written a proper
> changelog
> for it (it's in a set of 15 patches for netdev that fix harmless
> warnings).
> 
> Do you have one for the warning below as well? I could not come up
> with a better way than adding a bogus initialization, but maybe
> there is one.
> 
> ????????Arnd
> 
> From d89be3f0f932a71dfb5480ee396db514879097c4 Mon Sep 17 00:00:00
> 2001
> From: Arnd Bergmann <arnd@arndb.de>
> Date: Fri, 15 Jan 2016 17:31:07 +0100
> Subject: [PATCH] net: i40e: shut up uninitialized variable warnings
> 
> intel/i40e/i40e_txrx.c: In function 'i40e_xmit_frame_ring':
> intel/i40e/i40e_txrx.c:2367:20: error: 'oiph' may be used
> uninitialized in this function [-Werror=maybe-uninitialized]
> intel/i40e/i40e_txrx.c:2317:16: note: 'oiph' was declared here
> intel/i40e/i40e_txrx.c:2367:17: error: 'oudph' may be used
> uninitialized in this function [-Werror=maybe-uninitialized]
> intel/i40e/i40e_txrx.c:2316:17: note: 'oudph' was declared here
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Yeah, I have a fix for that as well.

You can confirm by pulling my next-queue tree (dev-queue branch).
git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git?d
ev-queue
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160120/1999289a/attachment-0001.sig>
