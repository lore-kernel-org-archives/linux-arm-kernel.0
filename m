From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Jul 2016 10:18:52 +0200
Subject: [PATCH v5 12/15] binfmt_flat: allow compressed flat binary format
 to work on MMU systems
In-Reply-To: <alpine.LFD.2.20.1607241612480.1594@knanqh.ubzr>
References: <1469374229-21585-1-git-send-email-nicolas.pitre@linaro.org>
 <4262519.L4vdOGcrh0@wuerfel> <alpine.LFD.2.20.1607241612480.1594@knanqh.ubzr>
Message-ID: <9805659.OeD7S5yAQd@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, July 24, 2016 4:25:16 PM CEST Nicolas Pitre wrote:
> On Sun, 24 Jul 2016, Arnd Bergmann wrote:
> 
> > On Sunday, July 24, 2016 11:30:26 AM CEST Nicolas Pitre wrote:
> > > +#else
> > > +                       /*
> > > +                        * This is used on MMU systems mainly for testing.
> > > +                        * Let's use a kernel buffer to simplify things.
> > > +                        */
> > > +                       long unz_text_len = text_len - sizeof(struct flat_hdr);
> > > +                       long unz_len = unz_text_len + full_data;
> > > +                       char *unz_data = vmalloc(unz_len);
> > > +                       if (!unz_data) {
> > > +                               result = -ENOMEM;
> > > 
> > 
> > Is there a risk of a malicious user exhausting vmalloc space with a
> > binary that has forged headers? If there is, maybe put an upper bound on
> > the size of allocation.
> 
> Patch #3 enforces a cap on all parameters to avoid overflows and 
> unreasonable section sizes.
> 
> Then vmalloc space is used here only for decompressing the binary into, 
> after which the whole thing is copied to user space and the vmalloc area 
> is freed right away.
> 
> > More broadly speaking, are there any other attacks that may get enabled
> > through forged binaries? We've had a couple of vulnerabilities in
> > binfmt_elf over the years, and I wonder how dangerous it might be
> > if distros turn on binfmt_flat support by default.
> 
> That was Alan's concern too which prompted patch #3. But with a clamp on 
> all parameters, everything else is done via user accessors.  So an 
> executable still can crap onto itself or generate a segfault but I doubt 
> we really care at that point.
> 

Ok, sounds good.

	Arnd
