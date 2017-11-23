From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 23 Nov 2017 11:46:56 +0100
Subject: [PATCH 00/18] arm64: Unmap the kernel whilst running in
 userspace (KAISER)
In-Reply-To: <CAKv+Gu-vsQiDS1kobmaBmnWv__vTuOcKHs6t2rMiVu=rriHeEQ@mail.gmail.com>
References: <1510942921-12564-1-git-send-email-will.deacon@arm.com>
 <20171122161913.GB12684@amd>
 <CAKv+Gu9xw92F_K5XhDwpuSWCSbVJOMGSszuGBkyrhqboLhA-Mw@mail.gmail.com>
 <20171122223355.GA5877@amd>
 <C271F3D3-A849-43F5-AE0A-6997890A3857@linaro.org>
 <20171122233738.GA25313@amd>
 <D3BCED36-58D1-4E30-9171-16F06A5DC65D@linaro.org>
 <20171123090747.GA6948@amd>
 <CAKv+Gu-vsQiDS1kobmaBmnWv__vTuOcKHs6t2rMiVu=rriHeEQ@mail.gmail.com>
Message-ID: <20171123104656.GA17990@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 2017-11-23 09:23:02, Ard Biesheuvel wrote:
> On 23 November 2017 at 09:07, Pavel Machek <pavel@ucw.cz> wrote:
> > Hi!
> >
> >> > On 22 Nov 2017, at 23:37, Pavel Machek <pavel@ucw.cz> wrote:
> >> >
> >> > Hi!
> >> >
> >> >>>>> If I'm willing to do timing attacks to defeat KASLR... what prevents
> >> >>>>> me from using CPU caches to do that?
> >> >>>>>
> >> >>>>
> >> >>>> Because it is impossible to get a cache hit on an access to an
> >> >>>> unmapped address?
> >> >>>
> >> >>> Um, no, I don't need to be able to directly access kernel addresses. I
> >> >>> just put some data in _same place in cache where kernel data would
> >> >>> go_, then do syscall and look if my data are still cached. Caches
> >> >>> don't have infinite associativity.
> >> >>>
> >> >>
> >> >> Ah ok. Interesting.
> >> >>
> >> >> But how does that leak address bits that are covered by the tag?
> >> >
> >> > Same as leaking any other address bits? Caches are "virtually
> >> > indexed",
> >>
> >> Not on arm64, although I don?t see how that is relevant if you are trying to defeat kaslr.
> >>
> >> > and tag does not come into play...
> >> >
> >>
> >> Well, I must be missing something then, because I don?t see how knowledge about which userland address shares a cache way with a kernel address can leak anything beyond the bits that make up the index (i.e., which cache way is being shared)
> >>
> >
> > Well, KASLR is about keeping bits of kernel virtual address secret
> > from userland. Leaking them through cache sidechannel means KASLR is
> > defeated.
> >
> 
> Yes, that is what you claim. But you are not explaining how any of the
> bits that we do want to keep secret can be discovered by making
> inferences from which lines in a primed cache were evicted during a
> syscall.
> 
> The cache index maps to low order bits. You can use this, e.g., to
> attack table based AES, because there is only ~4 KB worth of tables,
> and you are interested in finding out which exact entries of the table
> were read by the process under attack.
> 
> You are saying the same approach will help you discover 30 high order
> bits of a virtual kernel address, by observing the cache evictions in
> a physically indexed physically tagged cache. How?

I assumed high bits are hashed into cache index. I might have been
wrong. Anyway, page tables are about same size as AES tables. So...:

http://cve.circl.lu/cve/CVE-2017-5927

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171123/1f7f838b/attachment.sig>
