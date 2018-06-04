From: yaojun8558363@gmail.com (Jun Yao)
Date: Mon, 4 Jun 2018 19:45:08 +0800
Subject: [PATCH 0/4] arm64/mm: migrate swapper_pg_dir
In-Reply-To: <41dbb7d5-c9a5-3ed2-c0fe-a8bb8a3e487f@arm.com>
References: <20180601080819.11712-1-yaojun8558363@gmail.com>
 <41dbb7d5-c9a5-3ed2-c0fe-a8bb8a3e487f@arm.com>
Message-ID: <20180604114508.GC25382@toy>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 01, 2018 at 10:42:10AM +0100, Robin Murphy wrote:
> On 01/06/18 09:08, Jun Yao wrote:
> > Currently, The offset between swapper_pg_dir and _text is
> > fixed. When attackers know the address of _text(no KASLR or
> > breaking KASLR), they can caculate the address of
> > swapper_pg_dir. Then KSMA(Kernel Space Mirroring Attack) can
> > be applied.
> > 
> > The principle of KSMA is to insert a carefully constructed PGD
> > entry into the translation table. The type of this entry is
> 
> Out of interest, how does that part work? AFAICS, modifying a PGD entry
> involves writing to kernel memory, which would mean the implication of KSMA
> is "userspace can gain write permission to kernel memory by writing to
> kernel memory" - that doesn't sound like an attack in itself, more just a
> convenience for ease of exploiting whatever successful attack got you in
> there in the first place.
> 
> That's not to say that it isn't still worth mitigating, I'm just questioning
> the given rationale here.
> 
> Robin.

Yes, you are right. KSMA is just a convenience for ease of exploiting. I think
that the biggest role of KSMA is to covert an arbitrary write to multiple
arbitrary writes. In the past, to accomplish this, a function
pointer(e.g. ptmx_fops) is modified to point to gadget, which can r/w kernel
memory. However, PAN makes this more difficult. And KSMA becomes a new way to
do that.

For details on KSMA, you can refer to:

https://www.blackhat.com/docs/asia-18/asia-18-WANG-KSMA-Breaking-Android-kernel-isolation-and-Rooting-with-ARM-MMU-features.pdf

thanks,

Jun
