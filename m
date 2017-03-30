From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 29 Mar 2017 17:40:02 -0700
Subject: [RFC PATCH] Memory hotplug support for arm64 platform
In-Reply-To: <20170206111732.GA5589@samekh>
References: <1481717765-31186-1-git-send-email-m.bielski@virtualopensystems.com>
 <75156ea7-6e74-27e8-bf29-762f79151d23@broadcom.com>
 <7977063a-20bb-cc85-449f-51bb7d20761e@virtualopensystems.com>
 <6568a65d-79c0-6fe4-e4d0-f1d3fe205321@broadcom.com>
 <20170206111732.GA5589@samekh>
Message-ID: <ef53951f-ff03-91d2-506a-c5eccb6512b4@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrea, Maciej,

On 02/06/2017 03:17 AM, Andrea Reale wrote:
> Hi Scott,
> Hi all,
> 
> in reply to the issues that Scott reported last month, myself and Maciej
> investigated further by running quite a number of experiments on the
> physical and virtual environments we have avaialable.
> 
> We collected all the results and relevant logs in a Web page at
> https://hotplug-tests.eu-gb.mybluemix.net/ so that anyone interested can
> go there and check all the details.
> 
> The tl;dr version is that, in all configuration, we could not reproduce
> what Scott has described as "memory corruption". The only issue we
> encountered happens when the system is booted with a small amount of
> initial memory (e.g., mem=64M) and one tries to hot-add several sections
> of memory in ZONE_MOVABLE; in that case, the process is likely to fail
> when vmemmap tries to allocate chunks of 2^9 consecutive pages to make
> space for the `struct page`s describing the new memory; in fact, it
> seems likely that, in low memory situations, the system cannot find enough
> consecutive pages in ZONE_DMA or ZONE_NORMAL. This condition is not
> dependand on memory hot-plug; in fact, we counter-tested this by writing
> a simple module that just tries to allocate a few chunks of 2^9 pages,
> and we experienced that it fails when the system is booted with low
> memory (sources and logs in the Web page linked above).
> 
> @Scott: were your referring to this issue, by any chance, in your
> previous emails? If not, we would really appreciate if you could help us
> reproduce the condition you are experiencing and/or give us a more detail 
> of what are the symptoms of the corruption you are referring to.

One question regarding your patch posted here:
https://lkml.org/lkml/2016/12/14/188

While the "hack" that sets/clears NOMAP in order for pfn_valid() to
return false/true when appropriate during __add_pages() definitively
does seem to work to probe the memory section, don't you also hit the
same warning when you try to online that memory section in
pages_correctly_reserved() once you have cleared the NOMAP flag?

NB: I am working on the 4.1 kernel at the moment, but it seems to be
nearly identical in that regard.

> 
> We are still running additional tests on other boards and we will update
> the Web page while we get them. If anyone happens to try these patches
> on their system, we warmly invite to send feedback with either 
> negative or positive outcomes.

I will definitively give this a try on ARM64 since I need to get it
working there.

Do you mind posting a non-RFC patch?

Thanks!
--
Florian
