From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 30 Sep 2012 11:14:18 +0100
Subject: [PATCH 1/3] Revert "spi/pl022: fix spi-pl022 pm enable at probe"
In-Reply-To: <CACRpkdb+bnCzYV2Dzqou5kGyc1hrh0VT-pYXZm1auu4uik2GNg@mail.gmail.com>
References: <1348831266-16721-1-git-send-email-ulf.hansson@stericsson.com>
 <1348831266-16721-2-git-send-email-ulf.hansson@stericsson.com>
 <CACRpkdb+bnCzYV2Dzqou5kGyc1hrh0VT-pYXZm1auu4uik2GNg@mail.gmail.com>
Message-ID: <20120930101418.GF6933@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 30, 2012 at 10:44:17AM +0200, Linus Walleij wrote:
> On Fri, Sep 28, 2012 at 1:21 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:
> 
> > From: Ulf Hansson <ulf.hansson@linaro.org>
> >
> > This reverts commit 6887237cd7da904184dab2750504040c68f3a080.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> Why?
> 
> It was removed in this commit, is it wrong?

Linus, please read the previous thread on pl022.

The long and short of it is that your commit 2fb30d1147c599f5657e8c62c862f9a0f58d9d99
(spi/pl022: enable runtime PM) is totally broken, and Michel came along
trying to fix the resulting breakage by partially removing your commit
in 6887237cd7da904184dab2750504040c68f3a080 (spi/pl022: fix spi-pl022
pm enable at probe).

The reason why your commit is wrong is:

                pm_runtime_get_noresume(dev);
                pm_runtime_set_active(dev);
                pm_runtime_enable(dev);

                ret = pcdrv->probe(pcdev, id);

So, adding this in spi-pl022 probe:

+       pm_runtime_enable(dev);
+       pm_runtime_resume(dev);

makes the sequence:

	pm_runtime_get_noresume(dev);
	pm_runtime_set_active(dev);
	pm_runtime_enable(dev);
	pm_runtime_enable(dev);
	pm_runtime_resume(dev);

which is absolute rubbish.  Your commit should never have gone into any
tree.

The real answer is to revert both commits to get the driver back to a
sane state, before then progressing with the driver in a sane manner.
This is what Ulf is doing.
