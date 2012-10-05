From: mikpe@it.uu.se (Mikael Pettersson)
Date: Fri, 5 Oct 2012 15:49:05 +0200
Subject: alignment faults in 3.6
In-Reply-To: <CAG5Tg6WSRtwPkz9OEg6xS7X5uV6-U4o3GaxbTRW-jCfuMPdb=g@mail.gmail.com>
References: <506E1762.3010601@gmail.com>
 <CANLjY-no-L9=LRCvCetC5XCHicOoSWOfRZmUd7itAiUHWBhAyw@mail.gmail.com>
 <CAG5Tg6Wuybruc31x1eh6mFafsg=7cOgYLgpZUBuJUo75ap3osQ@mail.gmail.com>
 <506E3E58.80703@gmail.com>
 <CAG5Tg6V0Vj9HTy3=AU-q+Qa3DuJs6R1Kw+3uOWU_jOGfkgyXzw@mail.gmail.com>
 <20121005071216.GD4625@n2100.arm.linux.org.uk>
 <CAG5Tg6VciuxJ=k+fatzLugcehF54mGNOLHpUwdMX99oCnAVg8Q@mail.gmail.com>
 <20121005082439.GF4625@n2100.arm.linux.org.uk>
 <CAG5Tg6UabdyCbmMWr5vqyKfgHsYEzGLmx0=uBiPjyGUmVCejcQ@mail.gmail.com>
 <20121005083359.GH4625@n2100.arm.linux.org.uk>
 <CAG5Tg6WSRtwPkz9OEg6xS7X5uV6-U4o3GaxbTRW-jCfuMPdb=g@mail.gmail.com>
Message-ID: <20590.58705.406604.777880@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mans Rullgard writes:
 > On 5 October 2012 09:33, Russell King - ARM Linux
 > <linux@arm.linux.org.uk> wrote:
 > > On Fri, Oct 05, 2012 at 09:33:04AM +0100, Mans Rullgard wrote:
 > >> On 5 October 2012 09:24, Russell King - ARM Linux
 > >> <linux@arm.linux.org.uk> wrote:
 > >> > On Fri, Oct 05, 2012 at 09:20:56AM +0100, Mans Rullgard wrote:
 > >> >> On 5 October 2012 08:12, Russell King - ARM Linux
 > >> >> <linux@arm.linux.org.uk> wrote:
 > >> >> > On Fri, Oct 05, 2012 at 03:25:16AM +0100, Mans Rullgard wrote:
 > >> >> >> On 5 October 2012 02:56, Rob Herring <robherring2@gmail.com> wrote:
 > >> >> >> > This struct is the IP header, so a struct ptr is just set to the
 > >> >> >> > beginning of the received data. Since ethernet headers are 14 bytes,
 > >> >> >> > often the IP header is not aligned unless the NIC can place the frame at
 > >> >> >> > a 2 byte offset (which is something I need to investigate). So this
 > >> >> >> > function cannot make any assumptions about the alignment. Does the ABI
 > >> >> >> > define structs have some minimum alignment? Does the struct need to be
 > >> >> >> > declared as packed or something?
 > >> >> >>
 > >> >> >> The ABI defines the alignment of structs as the maximum alignment of its
 > >> >> >> members.  Since this struct contains 32-bit members, the alignment for the
 > >> >> >> whole struct becomes 32 bits as well.  Declaring it as packed tells gcc it
 > >> >> >> might be unaligned (in addition to removing any holes within).
 > >> >> >
 > >> >> > This has come up before in the past.
 > >> >> >
 > >> >> > The Linux network folk will _not_ allow - in any shape or form - for
 > >> >> > this struct to be marked packed (it's the struct which needs to be
 > >> >> > marked packed) because by doing so, it causes GCC to issue byte loads/
 > >> >> > stores on architectures where there isn't a problem, and that decreases
 > >> >> > the performance of the Linux IP stack unnecessarily.
 > >> >>
 > >> >> Which architectures?  I have never seen anything like that.
 > >> >
 > >> > Does it matter?
 > >>
 > >> It matters if we want to fix it.
 > >
 > > I can't help you there.  Ask the networking people.
 > 
 > I'm asking anyone who is listening.  Since you've (apparently) seen the claim
 > being made, perhaps you can point to an email or so with more information.
 > I'd hate to think you're just making up excuses.

I'm pretty sure I've seen DaveM make this statement (not allowing the packed
attribute) and also stating that alignment faults in the kernel itself MUST be
handled silently and correctly.  (And DaveM is of course also the maintainer
of SPARC, another machine with strict-alignment requirements.)
