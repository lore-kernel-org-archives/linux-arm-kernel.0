From: will.deacon@arm.com (Will Deacon)
Date: Mon, 21 Sep 2015 22:09:38 +0100
Subject: ARM64 readahead: fault retry breaks mmap file read random
 detection
In-Reply-To: <1442868028-27055-1-git-send-email-salyzyn@android.com>
References: <1442868028-27055-1-git-send-email-salyzyn@android.com>
Message-ID: <20150921210938.GC7356@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 21, 2015 at 09:39:50PM +0100, Mark Salyzyn wrote:
> Description from commit 45cac65b0fcd
>     ("readahead: fault retry breaks mmap file read random detection")
> 
> .fault now can retry.  The retry can break state machine of .fault.  In
> filemap_fault, if page is miss, ra->mmap_miss is increased.  In the second
> try, since the page is in page cache now, ra->mmap_miss is decreased.  And
> these are done in one fault, so we can't detect random mmap file access.
> 
> Add a new flag to indicate .fault is tried once.  In the second try, skip
> ra->mmap_miss decreasing.  The filemap_fault state machine is ok with it.
> 
> I only tested x86, didn't test other archs, but looks the change for other
> archs is obvious, but who knows :)
> 
> < snip >
> 
> Yup, arm64 needs this too! Random read improves by 250%, sequential
> read improves by 40%, and random write by 400% to an eMMC device with
> dm crypto wrapped around it.

Thanks for this. This must've gone in whilst we were developing the initial
version of the arm64 port and has since gone unnoticed.

I'll queue it on the arm64 fixes branch and send a pull request after
some testing.

Will
