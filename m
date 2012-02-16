From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Thu, 16 Feb 2012 17:01:42 +0000
Subject: Oops in guest after ioremap() on ARMv7
In-Reply-To: <CAHkRjk68rw2TKnitc7M+R1FCpwrGkqFHwd4YmS78mveR9uO_2Q@mail.gmail.com>
References: <4EF31DA7.9030407@citrix.com> <20111222144937.GE20635@arm.com>
 <4EF35CFF.3050200@citrix.com> <20111222181356.GI20635@arm.com>
 <4EF37802.30300@citrix.com>
 <1324641625.7877.161.camel@zakaz.uk.xensource.com>
 <20120103165027.GD22876@arm.com>
 <1326994510.17599.97.camel@zakaz.uk.xensource.com>
 <CAHkRjk68rw2TKnitc7M+R1FCpwrGkqFHwd4YmS78mveR9uO_2Q@mail.gmail.com>
Message-ID: <1329411702.3133.4.camel@zakaz.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On Tue, 2012-01-31 at 14:40 +0000, Catalin Marinas wrote:
> On 19 January 2012 17:35, Ian Campbell <Ian.Campbell@citrix.com> wrote:
> > On Tue, 2012-01-03 at 16:50 +0000, Catalin Marinas wrote:
> >> On Fri, Dec 23, 2011 at 12:00:25PM +0000, Ian Campbell wrote:
> >> > At the moment we build the entire p2m before we ever load the VTTBR or
> >> > enable stage-2 translations in the HCR. Is that sufficient or do we also
> >> > need to flush something?
> >>
> >> If the model does not correctly implement cacheable page table walks for
> >> either stage 1 or stage 2 translation (though ID_MMFR3[23:20] indicate
> >> that it should), the hypervisor would need to clean the D-cache to the
> >> point of unification (not necessary to go to the point of coherency)
> >> before any of the state 2 translation tables are used.
> >
> > I added a copy of Linux's v7_flush_dcache_all after building the p2m but
> > just before loading the VTTBR and it didn't help.
> >
> > I turned off cacheability in VTCR and that didn't help either.
> >
> > Then I turned off cacheability in the Linux TTBR{0,1} (by frobbing both
> > TTB_FLAGS_UP and TTB_FLAGS_SMP to use FOO_NC everywhere) and this _did_
> > make a difference -- the kernel now boots.
> >
> > I then tested just that change by itself and it seems to have done the
> > trick.
> >
> > Does that indicate a model bug?
> 
> It is possible. The scenario I'm thinking of is that with cacheable
> PTWs enabled in TTBR, the model wrongly decides to use the
> intermediate physical address (IPA) to look up the caches and gets the
> wrong information.
> 
> I'll take this to the model guys but most likely they'll ask for an
> image to load and just run. Could you provide such simple image
> (minimal filesystem)? I'm not familiar with Xen and building it.
> 
> (I'll first ask the model guys, maybe they can spot the error easily
> without additional debugging).

Did they conclude anything? Can I provide any more info?

Ian.
