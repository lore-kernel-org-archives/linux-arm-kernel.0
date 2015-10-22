From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 22 Oct 2015 12:13:07 +0100
Subject: [RFC PATCH v6 3/3] arm: fix a migrating irq bug when hotplug cpu
In-Reply-To: <5628C0DD.50900@huawei.com>
References: <1443087135-17044-1-git-send-email-yangyingliang@huawei.com>
 <1443087135-17044-4-git-send-email-yangyingliang@huawei.com>
 <CAMuHMdWyvaecQHOzFnxVZus_Pfkxjw1XfkGdcLK=D2ThaoJMzA@mail.gmail.com>
 <20151021202907.GN32532@n2100.arm.linux.org.uk>
 <20151022092629.GQ32532@n2100.arm.linux.org.uk>
 <5628C0DD.50900@huawei.com>
Message-ID: <20151022111307.GS32532@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 22, 2015 at 06:56:29PM +0800, Yang Yingliang wrote:
> I described it in v2 cover letter and kept the change history in v6
> cover letter. There is no comment on the change when patch the was
> reviewing in v2, so I thought it's ok and I kept the change in the
> next versions.

Cover letters don't always get read, neither do changelogs.

However, there's a principle here: never mix moving code around with
changes to that code.  Always move code with as few changes as possible
in one patch, and then make changes in a subsequent patch.

The "few changes as possible" means that if you need to make changes
for it to end up building in its new location, such as removing a
'static' or adding an 'EXPORT_SYMBOL' then those are fine, but the
main body of the code should remain identical, even down to style.

Any changes (such as, in this case, replacing pr_debug with pr_warn)
should be done as a distinctly separate patch so that such changes
are immediately obvious to reviewers.

> Need I send a patch to the Thomas branch to revert the change ?

I think wait for Thomas and Catalin to reply.  Your patch series is
currently merged into two different trees (Thomas' and Catalin's
trees) and what action is needed depends on how they want to handle
it.

The solutions are:
* A patch to restore the pr_debug() which Thomas applies, and Catalin
  and myself then pull Thomas' tree again, which potentially creates
  a messier history.

* Catalin drops the ARM64 change and Thomas' tree from the ARM64 tree,
  Thomas drops the original commit, and we start again doing it
  correctly.

Which is up to Catalin and Thomas.

I've dropped it from my tree as an easy way to fix the regression
on ARM for the time being, pending the outcome of deciding how to
fix this.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
