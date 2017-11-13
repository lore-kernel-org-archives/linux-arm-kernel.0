From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Nov 2017 09:34:23 +0000
Subject: linux-next: Tree for Nov 7
In-Reply-To: <20171113092006.cjw2njjukt6limvb@dhcp22.suse.cz>
References: <20171107162217.382cd754@canb.auug.org.au>
 <CACPK8Xfd4nqkf=Lk3n6+TNHAAi327r0dkUfGypZ3TpR0LqfS4Q@mail.gmail.com>
 <20171108142050.7w3yliulxjeco3b7@dhcp22.suse.cz>
 <20171110123054.5pnefm3mczsfv7bz@dhcp22.suse.cz>
 <CACPK8Xe5uUKEytkRiszdX511b_cYTD-z3X=ZsMcNJ-NOYnXfuQ@mail.gmail.com>
 <20171113092006.cjw2njjukt6limvb@dhcp22.suse.cz>
Message-ID: <20171113093423.GI12318@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 13, 2017 at 10:20:06AM +0100, Michal Hocko wrote:
> [Cc arm and ppc maintainers]
> 
> Thanks a lot for testing!
> 
> On Sun 12-11-17 11:38:02, Joel Stanley wrote:
> > On Fri, Nov 10, 2017 at 11:00 PM, Michal Hocko <mhocko@kernel.org> wrote:
> > > Hi Joel,
> > >
> > > On Wed 08-11-17 15:20:50, Michal Hocko wrote:
> > > [...]
> > >> > There are a lot of messages on the way up that look like this:
> > >> >
> > >> > [    2.527460] Uhuuh, elf segement at 000d9000 requested but the
> > >> > memory is mapped already
> > >> > [    2.540160] Uhuuh, elf segement at 000d9000 requested but the
> > >> > memory is mapped already
> > >> > [    2.546153] Uhuuh, elf segement at 000d9000 requested but the
> > >> > memory is mapped already
> > >> >
> > >> > And then trying to run userspace looks like this:
> > >>
> > >> Could you please run with debugging patch posted
> > >> http://lkml.kernel.org/r/20171107102854.vylrtaodla63kc57 at dhcp22.suse.cz
> > >
> > > Did you have chance to test with this debugging patch, please?
> > 
> > Lots of this:
> > 
> > [    1.177266] Uhuuh, elf segement at 000d9000 requested but the  memory is mapped already, got 000dd000
> > [    1.177555] Clashing vma [dd000, de000] flags:100873 name:(null)
> 
> This smells like the problem I've expected that mmap with hint doesn't
> respect the hint even though there is no clashing mapping. The above
> basically says that we didn't map at 0xd9000 but it has placed it at
> 0xdd000. The nearest (clashing) vma is at 0xdd000 so this is our new
> mapping. find_vma returns the closest vma (with addr < vm_end) for the
> given address 0xd9000 so this address cannot be mapped by any other vma.
> 
> Now that I am looking at arm's arch_get_unmapped_area it does perform
> aligning for shared vmas. We do not do that for MAP_FIXED.  Powepc,
> reported earlier [1] seems to suffer from the similar problem.
> slice_get_unmapped_area alignes to slices, whatever that means.
> 
> I can see two possible ways around that. Either we explicitly request
> non-aligned mappings via a special MAP_$FOO (e.g. MAP_FIXED_SAFE) or
> simply opt out from the MAP_FIXED protection via ifdefs. The first
> option sounds more generic to me but also more tricky to not introduce
> other user visible effects. The later is quite straightforward. What do
> you think about the following on top of the previous patch?
> 
> It is rather terse and disables the MAP_FIXED protection for arm
> comletely because I couldn't find a way to make it conditional on
> CACHEID_VIPT_ALIASING. But this can be always handled later. I find the
> protection for other archtectures useful enough to have this working for
> most architectures now and handle others specially.

Can someone provide the background information for this please?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
