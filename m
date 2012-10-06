From: mikpe@it.uu.se (Mikael Pettersson)
Date: Sat, 6 Oct 2012 12:58:49 +0200
Subject: alignment faults in 3.6
In-Reply-To: <506F0454.3070304@gmail.com>
References: <506E1762.3010601@gmail.com>
 <CANLjY-no-L9=LRCvCetC5XCHicOoSWOfRZmUd7itAiUHWBhAyw@mail.gmail.com>
 <CAG5Tg6Wuybruc31x1eh6mFafsg=7cOgYLgpZUBuJUo75ap3osQ@mail.gmail.com>
 <506E3E58.80703@gmail.com>
 <CAG5Tg6V0Vj9HTy3=AU-q+Qa3DuJs6R1Kw+3uOWU_jOGfkgyXzw@mail.gmail.com>
 <20121005071216.GD4625@n2100.arm.linux.org.uk>
 <CAG5Tg6VciuxJ=k+fatzLugcehF54mGNOLHpUwdMX99oCnAVg8Q@mail.gmail.com>
 <20121005082439.GF4625@n2100.arm.linux.org.uk>
 <506ED18C.3010009@gmail.com>
 <20590.58864.527467.746403@pilspetsen.it.uu.se>
 <506F0454.3070304@gmail.com>
Message-ID: <20592.3817.788006.973760@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob Herring writes:
 > On 10/05/2012 08:51 AM, Mikael Pettersson wrote:
 > > Rob Herring writes:
 > >  > On 10/05/2012 03:24 AM, Russell King - ARM Linux wrote:
 > >  > > On Fri, Oct 05, 2012 at 09:20:56AM +0100, Mans Rullgard wrote:
 > >  > >> On 5 October 2012 08:12, Russell King - ARM Linux
 > >  > >> <linux@arm.linux.org.uk> wrote:
 > >  > >>> On Fri, Oct 05, 2012 at 03:25:16AM +0100, Mans Rullgard wrote:
 > >  > >>>> On 5 October 2012 02:56, Rob Herring <robherring2@gmail.com> wrote:
 > >  > >>>>> This struct is the IP header, so a struct ptr is just set to the
 > >  > >>>>> beginning of the received data. Since ethernet headers are 14 bytes,
 > >  > >>>>> often the IP header is not aligned unless the NIC can place the frame at
 > >  > >>>>> a 2 byte offset (which is something I need to investigate). So this
 > >  > >>>>> function cannot make any assumptions about the alignment. Does the ABI
 > >  > >>>>> define structs have some minimum alignment? Does the struct need to be
 > >  > >>>>> declared as packed or something?
 > >  > >>>>
 > >  > >>>> The ABI defines the alignment of structs as the maximum alignment of its
 > >  > >>>> members.  Since this struct contains 32-bit members, the alignment for the
 > >  > >>>> whole struct becomes 32 bits as well.  Declaring it as packed tells gcc it
 > >  > >>>> might be unaligned (in addition to removing any holes within).
 > >  > >>>
 > >  > >>> This has come up before in the past.
 > >  > >>>
 > >  > >>> The Linux network folk will _not_ allow - in any shape or form - for
 > >  > >>> this struct to be marked packed (it's the struct which needs to be
 > >  > >>> marked packed) because by doing so, it causes GCC to issue byte loads/
 > >  > >>> stores on architectures where there isn't a problem, and that decreases
 > >  > >>> the performance of the Linux IP stack unnecessarily.
 > >  > >>
 > >  > >> Which architectures?  I have never seen anything like that.
 > >  > > 
 > >  > > Does it matter?  I'm just relaying the argument against adding __packed
 > >  > > which was used before we were forced (by the networking folk) to implement
 > >  > > the alignment fault handler.
 > >  > 
 > >  > It doesn't really matter what will be accepted or not as adding __packed
 > >  > to struct iphdr doesn't fix the problem anyway. gcc still emits a ldm.
 > >  > The only way I've found to eliminate the alignment fault is adding a
 > >  > barrier between the 2 loads. That seems like a compiler issue to me if
 > >  > there is not a better fix.
 > > 
 > > If you suspect a GCC bug, please prepare a standalone user-space test case
 > > and submit it to GCC's bugzilla (I can do the latter if you absolutely do not
 > > want to).  It wouldn't be the first alignment-related GCC bug...
 > > 
 > 
 > Here's a testcase. Compiled on ubuntu precise with
 > "arm-linux-gnueabihf-gcc -O2 -marm -march=armv7-a test.c".
 > 
 > typedef unsigned short u16;
 > typedef unsigned short __sum16;
 > typedef unsigned int __u32;
 > typedef unsigned char __u8;
 > typedef __u32 __be32;
 > typedef u16 __be16;
 > 
 > struct iphdr {
 > 	__u8	ihl:4,
 > 		version:4;
 > 	__u8	tos;
 > 	__be16	tot_len;
 > 	__be16	id;
 > 	__be16	frag_off;
 > 	__u8	ttl;
 > 	__u8	protocol;
 > 	__sum16	check;
 > 	__be32	saddr;
 > 	__be32	daddr;
 > 	/*The options start here. */
 > };
 > 
 > #define ntohl(x) __swab32((__u32)(__be32)(x))
 > #define IP_DF		0x4000		/* Flag: "Don't Fragment"	*/
 > 
 > static inline __attribute__((const)) __u32 __swab32(__u32 x)
 > {
 > 	__asm__ ("rev %0, %1" : "=r" (x) : "r" (x));
 > 	return x;
 > }
 > 
 > int main(void * buffer, unsigned int *p_id)
 > {
 > 	unsigned int id;
 > 	int flush = 1;
 > 	const struct iphdr *iph = buffer;
 > 	__u32 len = *p_id;
 > 	
 > 	id = ntohl(*(__be32 *)&iph->id);
 > 	flush = (u16)((ntohl(*(__be32 *)iph) ^ len) | (id ^ IP_DF));
 > 	id >>= 16;
 > 	
 > 	*p_id = id;
 > 	return flush;
 > }
 > 

I was referring to your statement that adding __packed to the types involved
didn't prevent GCC from emitting aligned memory accesses. The test case above
only shows that if the source code lies to GCC then things break...
