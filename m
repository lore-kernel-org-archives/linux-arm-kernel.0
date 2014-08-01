From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 1 Aug 2014 19:00:35 +0100
Subject: [PATCH 2/5] arm64, thunder: Add initial dts for Cavium Thunder SoC
In-Reply-To: <20140801170411.GG4703@rric.localhost>
References: <1406732794-20920-1-git-send-email-rric@kernel.org>
 <1406732794-20920-3-git-send-email-rric@kernel.org>
 <20140730154626.GD20162@leverpostej>
 <CAFpQJXWKybVUxpHg8MVrVMjLj3swuxLGo_9r1tL+gZ4hxUHTzQ@mail.gmail.com>
 <20140731095336.GB21850@leverpostej>
 <CAFpQJXUtP=v7FSLd3_OU7FG3w=pKYy2ihTQULA_DPEacsSu0Og@mail.gmail.com>
 <20140731113301.GE22994@leverpostej>
 <20140801170411.GG4703@rric.localhost>
Message-ID: <20140801180035.GF3264@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 01, 2014 at 06:04:11PM +0100, Robert Richter wrote:
> Mark,

Hi Robert,

> On 31.07.14 12:33:01, Mark Rutland wrote:
> > On Thu, Jul 31, 2014 at 12:12:33PM +0100, Ganapatrao Kulkarni wrote:
> > >    We mark RAM used by ATF as secure-RAM, however we don't support
> > >    secure/non-secure address aliasing.
> > >    i.e, a DRAM address that can be referenced from both a secure PA and a
> > >    non-secure PA is not allowed.
> >
> > What exactly do you mean by "not allowed"?
> 
> It actually means "not possible" since secure and non-secure memory is
> kept in separate address ranges.

I understand that the two are separate physical address spaces, but
Ganapatrao's reply was somewhat ambiguous and it wasn't clear to me that
the memory was actually marked as secure.

> > If Linux maps that memory, what happens?
> >
> > What if Linux tried to read or write to it?
> >
> > If Linux should not map that memory, it should not be described in the
> > memory map to begin with.
> 
> Linux never will see secure-RAM. Firmware must be sure to report the
> correct non-secure memory ranges to the OS (e.g. unsecure mem size =
> total size - secure mem size).

Ok, that's what I had hoped for and that makes sense.

The issue was that the memory node contained an address range that was
supposedly secure-only (which Linux could attempt to map), which was
'protected' with a /memreserve/ (which does not stop it from being
mapped).

Given they are unnecessary (unless you want to bypass EFI for some
reason) they can be dropped.

Thanks,
Mark.
