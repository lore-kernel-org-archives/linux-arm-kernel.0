From: computersforpeace@gmail.com (Brian Norris)
Date: Wed, 2 Sep 2015 13:47:10 -0700
Subject: [PATCH v2] nand: sunxi: fix write to USER_DATA reg
In-Reply-To: <1441180621-29708-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1441180621-29708-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20150902204710.GU81844@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 02, 2015 at 09:57:01AM +0200, Boris Brezillon wrote:
> Also drop the oob_required contidion, since ->oob_pio already contains
> FFs when oob_required is false.

I was pointing out this issues not just because you didn't note it in
the commit message, but because the previous behavior actually
potentially has user-visible effects. Particularly, because you had the
conditions backwards, you were programming 0xff to the spare area, no
matter what the user asked for. Normally, this isn't a big issue, since
most users aren't storing data in the OOB region. But there may be cases
where your driver was subtly broken (marking bad blocks, perhaps?), and
this patch is subtly fixing them. Especially since this will get
backported to -stable, it'd be nice to have this noted completely.

Did this driver pass mtd_oobtest previously?

Brian
