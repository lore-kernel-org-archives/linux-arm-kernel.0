From: horms@verge.net.au (Simon Horman)
Date: Tue, 6 Aug 2013 10:07:38 +0900
Subject: [PATCH v6 3/3] ARM: shmobile: lager: enable nfsroot in DTS
In-Reply-To: <20130801080226.GF15265@verge.net.au>
References: <1375175361-23027-1-git-send-email-horms+renesas@verge.net.au>
 <1375175361-23027-4-git-send-email-horms+renesas@verge.net.au>
 <87bo5h3lb3.wl%kuninori.morimoto.gx@renesas.com>
 <20130801080226.GF15265@verge.net.au>
Message-ID: <20130806010736.GA20940@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 01, 2013 at 05:02:28PM +0900, Simon Horman wrote:
> On Thu, Aug 01, 2013 at 12:46:44AM -0700, Kuninori Morimoto wrote:
> > 
> > Hi Simon
> > 
> > > Now that Ether support has been added to the lager board
> > > it is possible to use nfsroot. This configuration is
> > > in line with that of other shmobile boards.
> > > 
> > > Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> > > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > (snip)
> > >  	chosen {
> > > -		bootargs = "console=ttySC6,115200 ignore_loglevel";
> > > +		bootargs = "console=ttySC6,115200 ignore_loglevel root=/dev/nfs ip=dhcp nfsroot=,rsize=4096,wsize=4096 rw";
> > 
> > Could you please add why this "rsize/wsize" settings
> > are needed on bootargs ?
> > (other shmobile board's dts file doesn't have these)
> > 
> > And, I guess r8a7790-lager.dts/r8a7790.dts doesn't have
> > "sh-eth" driver DT settings, (or I'm missing ?)
> > but you added network/nfsroot settings on bootargs.
> > It is OK for me, but for what ?
> 
> I think it is copy-paste noise.
> I'll remove them.

To clarify:

The purpose of adding NFS information to bootargs in r8a7790-lager.dts is
to cause the lager board to use NFS root when booting from using the C
version of the board code which lives in board-lager.c. This is in contrast
to the DT reverence version of the board code, which uses DT more heavily,
does not initialise sh-eth because DT bindings are not available (as far as
I know) and is not effected by r8a7790-lager.dts.

Historically this kind of NFS information was added to the command line in
the defconfig.  However, as part of the long journey to consolidate (reduce
the number of) shmobile defconfigs it now goes in DT instead.


With regards to the "rsize/wsize" settings, I will remove them.
However, I do see them present in the following files and I believe
historically they were present in some of the shmobile defconfigs.

emev2-kzm9d-reference.dts
emev2-kzm9d.dts
r8a7740-armadillo800eva-reference.dts
r8a7740-armadillo800eva.dts
