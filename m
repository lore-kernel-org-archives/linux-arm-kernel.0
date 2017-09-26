From: ynorov@caviumnetworks.com (Yury Norov)
Date: Tue, 26 Sep 2017 14:54:24 +0300
Subject: ARM64: kernel panics in DABT in sys_msync path
In-Reply-To: <20170926102324.GC8693@arm.com>
References: <20170924213622.75e7r3k56tgxlezh@yury-thinkpad>
 <20170925105335.GA24042@arm.com>
 <20170925140240.vl5mvbce5lb37dxe@yury-thinkpad>
 <20170925190426.6prpcfn7lly26clm@yury-thinkpad>
 <a3b714ae-97a5-8458-9bf7-140eeeebc4b9@codeaurora.org>
 <20170926102324.GC8693@arm.com>
Message-ID: <20170926115424.yuowylwpwvjlh5cc@yury-thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 26, 2017 at 11:23:24AM +0100, Will Deacon wrote:
> On Mon, Sep 25, 2017 at 01:54:57PM -0600, Ruigrok, Richard wrote:
> > I also found this issue with kernels from 4.11 through 4.13.  In my tests, I
> > found that it reproduces only with 4K page and Transparent Huge Pages. With 64K
> > page I was not able to reproduce. RH also reported it here: https://
> > bugzilla.redhat.com/show_bug.cgi?id=1491504 Linaro reported on the RPK kernel
> > (4.12) on Centriq2400 and ThunderX
> >  
> > 
> > https://bugs.linaro.org/show_bug.cgi?id=3191
> > 
> > https://bugs.linaro.org/show_bug.cgi?id=3068.
> 
> These two aren't the same bug (that's a forward progress issue that we're
> currently working on). I don't have permission to look at the redhat one,
> but is it just an RCU stall or actually the Oops reported by Yury?
> 
> > I was able to bisect down to a specific commit.
> 
> I think we're chasing two different things here, so not sure I trust the
> bisect!
> 
> Will

I ran test 30 times on 4.14-rc2 kernel with 64K pages, and no panics
happened. So it may be same bug though, or somehow related? I'll do
some bisects and report results here.

Yury

> > First bad commit is:
> > commit f27176cfc363d395eea8dc5c4a26e5d6d7d65eaf
> > Author: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Date: Fri Feb 24 14:57:57 2017 -0800
> > 
> > mm: convert page_mkclean_one() to use page_vma_mapped_walk()
> > 
> > For consistency, it worth converting all page_check_address() to
> > page_vma_mapped_walk(), so we could drop the former.
> > 
> > PMD handling here is future-proofing, we don't have users yet. ext4
> > with huge pages will be the first.
> > 
> > I did not use virtualization, simply booting kernel and running the LTP
> > rwtest:   ./runltp -p -f fs -s rwtest
> > To validate bisecting (good points), I ran 30 iterations.  Usually it
> > reproduces in 5-10 iterations.
> > 
> > If you have any suggestions for instrumentation I can run tests, we can work
> > with 4.13 or on 4.11 at the above bisect point.
> > I have not tried the 4.14-rc's yet.
