From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 13 Aug 2015 22:29:36 +0100
Subject: [PATCH 3/7] drm/vc4: Add KMS support for Raspberry Pi.
In-Reply-To: <87d1yqq5po.fsf@eliezer.anholt.net>
References: <1439427380-2436-1-git-send-email-eric@anholt.net>
 <1439427380-2436-4-git-send-email-eric@anholt.net>
 <20150813075141.GX17734@phenom.ffwll.local>
 <87d1yqq5po.fsf@eliezer.anholt.net>
Message-ID: <20150813212936.GT7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 13, 2015 at 01:44:03PM -0700, Eric Anholt wrote:
> Struct mutex is here because this code is from the V3D series, with the
> in-kernel BO cache ripped out (it turns out that the CMA allocator is
> slow, and you can't just userspace cache since we have to do allocations
> within the kernel to the tune of a couple per draw and that's too much).

The CMA allocator is fast until you have pinned pages in its region,
where it becomes _very_ slow to do allocations, sometimes getting up
to the order of seconds.

The main culpret of this are GFP_HIGHUSER_MOVABLE allocations which
then pin the page.  It doesn't take many of those to make CMA really
inefficient.

The problem is that CMA doesn't get any information back from the
internal page migration about which pages couldn't be moved, so it
dumbly just tries incrementing the allocation by one page (subject
to alignment constraints) and retrying again - repeating over the
entire CMA region.  The bigger the region, the more time this takes.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
