From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 31 Mar 2016 11:38:00 +0100
Subject: [PATCH 2/7] ARM: dts: skeleton: add unit name to memory node
In-Reply-To: <CAGhQ9Vykn=G+cmVuBCAA_ATTz4XNEPeUWYbZRb5NsrVBOjaS-A@mail.gmail.com>
References: <1459290646-3592-1-git-send-email-manabian@gmail.com>
 <1459290646-3592-3-git-send-email-manabian@gmail.com>
 <20160330110611.GB25354@leverpostej> <56FBCF70.80006@mentor.com>
 <20160330134155.GC25354@leverpostej>
 <CAGhQ9VykiwMWaw3xcJdg2CahNFt+sp7tFC5O8VwA=-_=UoJ8kA@mail.gmail.com>
 <20160330170645.GA13690@leverpostej>
 <CAGhQ9Vykn=G+cmVuBCAA_ATTz4XNEPeUWYbZRb5NsrVBOjaS-A@mail.gmail.com>
Message-ID: <20160331103800.GC26532@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 30, 2016 at 10:45:06PM +0200, Joachim Eastwood wrote:
> On 30 March 2016 at 19:06, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Wed, Mar 30, 2016 at 06:15:35PM +0200, Joachim Eastwood wrote:
> >> I used the following script to check for the memory node in all built dtb's.
> >>   make ARCH=arm CONFIG_OF_ALL_DTBS=y dtbs
> >>   for i in $(ls arch/arm/boot/dts/*.dtb); do
> >>          m=$(scripts/dtc/dtc -I dtb -O dts $i | grep -m1 'memory.*{')
> >>          if [ -z "$m" ]; then
> >>                  echo "Missing memory node in $i"
> >>           fi
> >>   done
> >>
> >> So it should be pretty safe to just remove the memory node entry in
> >> the skeleton files. Unless I have missed something with the script
> >> above.
> >
> > The above might match reserved-memory nodes; it might be better to check
> > for 'device_type\s*=\s*"memory"'.
> 
> I did check the output of the grep and it looks good. But there are
> indeed DTs that are missing the 'device_type = "memory"' parameter.
> Actually; _a lot_ or 438 of 741 to be exact. ugh...
> 
> I guess all those should be fixed up before we can remove the memory
> node from skeleton. :/

Ouch, yes. :(

That said, the cahnges don't need to be an atomic operation. We could
start adding device_type = "memory" to dts immediately (in as whatever
size batches maintainers are happy with), as a duplicate device_type
shouldn't be problematic.

When we hit critical mass, we could then remove the skeleton memory
nodes, fixing up any remaining fallout.

As for the mechanical changes, it sounds like we need coccinelle for DT.

That, or a laptop, a long flight, and a gin and tonic.

Thanks,
Mark.
