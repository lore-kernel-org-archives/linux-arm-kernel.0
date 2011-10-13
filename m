From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 13 Oct 2011 09:59:06 +0100
Subject: change_page_attr() implementation for ARM?
In-Reply-To: <20111013084947.GI21648@n2100.arm.linux.org.uk>
References: <D19EBEE1D7B1F742A8ED7130E050A38A4CA460FF0C@HQMAIL02.nvidia.com>
	<CAHkRjk4mqhu+HhoSAnowk6=5GzXXhmKCE-3jrjhMpVzbtakFYg@mail.gmail.com>
	<401E54CE964CD94BAE1EB4A729C7087E3722519EE2@HQMAIL04.nvidia.com>
	<20111013084947.GI21648@n2100.arm.linux.org.uk>
Message-ID: <CAHkRjk7BukuyHHLb8XCdZGixOkzho-jFaMLOfrvkbk6ScBpi5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 October 2011 09:49, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Oct 12, 2011 at 07:27:58PM -0700, Krishna Reddy wrote:
>> >The kernel linear mapping is done using sections, so we would have to
>> >change the attributes for a full section. Russell's approach I think
>> >is better but people reported some stability issues.
...
>> does Russell's approach refer to a different way?
>> Is there any link on how Russell wants to do it?
>
> I had a patch which pre-allocates memory for the DMA allocators, but I
> had to drop it because it caused regressions on platforms which had
> very limited DMA memory available - it caused such platforms to panic
> at boot.
>
> So, this is proving to be an extremely difficult problem to solve -
> and I've been wishing for quite a long time that ARM Ltd would get
> their act together and realize that the combination of restrictions
> (DMA incoherence plus not permitting aliases) is Very Bad News.
>
> So, I'm hoping that there's an increasing chorus of voices trying to
> persuade a move towards data-cache DMA coherence as standard.

I mentioned the mismatched aliases clarification on several occasions,
though in private emails as the ARM ARM revC is not public yet. IIRC I
even sent a short document to a few people including you. Is that
clarification not enough (I can send it again if you want)?

Basically with Normal Non-cacheable DMA buffers (but not Strongly
Ordered) we are ok as long as the caches are cleaned on the other
Normal Cacheable mapping. Of course, you get different behaviour with
PL310 if you don't set bit 22 but that's a documented bit and not some
undocumented errata workaround (maybe this bit should have been 1 by
default).

-- 
Catalin
