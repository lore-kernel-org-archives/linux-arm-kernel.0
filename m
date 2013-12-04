From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 4 Dec 2013 10:40:11 +0100
Subject: [PATCH v2] OF: base: match each node compatible against all
 given matches first
In-Reply-To: <529E614B.3070307@gmail.com>
References: <1385663785-8643-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1386078720-8756-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <alpine.SOC.1.00.1312032210480.25191@math.ut.ee>
 <529E614B.3070307@gmail.com>
Message-ID: <20131204094010.GO19943@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 03, 2013 at 11:55:07PM +0100, Sebastian Hesselbarth wrote:
> On 12/03/2013 09:14 PM, Meelis Roos wrote:
> >>Currently, of_match_node compares each given match against all node's
> >>compatible strings with of_device_is_compatible.
> >>
> >>To achieve multiple compatible strings per node with ordering from
> >>specific to generic, this requires given matches to be ordered from
> >>specific to generic. For most of the drivers this is not true and also
> >>an alphabetical ordering is more sane there.
> >>
> >>Therefore, this patch modifies of_match_node to match each of the node's
> >>compatible strings against all given matches first, before checking the
> >>next compatible string. This implies that node's compatibles are ordered
> >>from specific to generic while given matches can be in any order.
> >
> >I think I am on the CC: list because of a CPU detection problem report
> >on sparc64 (183912d352a242a276a7877852f107459a13aff9 (of: move
> >of_get_cpu_node implementation to DT core library) caused trouble and
> 
> The reason you are on Cc is that Thierry added you on last patch
> version. I cannot see how above commit should be related with this
> one, but maybe Thierry can comment on it.
> 
> >was reverted). So while your V2 patch does not cause any visible harm on
> >the same Sun E3500, my gut feeling is that an additional patch would be
> >needed to actually test it (a patch like
> >183912d352a242a276a7877852f107459a13aff9).
> 
> This patch deals with matching a node with more than one compatible
> string on a (unordered) list of matches. Although not related to your
> issue, it is good to hear that it causes no harm on DT-mature archs :)
> 
> I tested it with ARM and l2x0 cache controllers, where the specific
> of_device_id (marvell,tauros3-cache) is sorted after the generic
> one (arm,pl310-cache). The corresponding node's property is
> compatible = "marvell,tauros3-cache", "arm,pl310-cache".
> 
> Without this patch, of_match_node always hits the first match that
> equals _any_ of the above compatible strings. With this patch, it
> hits the matches _in order_ of the compatible strings.
> 
> >Is this correct or am I missing something?
> 
> Thierry?

I added Meelis on Cc because he found a regression with my original
proposal (107a84e61cdd "of: match by compatible property first"). That
got later reverted in commit bc51b0c22ceb (Revert "of: match by
compatible property first"). Here's the commit message for reference:

commit bc51b0c22ceb
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue Jul 10 12:49:32 2012 -0700

    Revert "of: match by compatible property first"

    This reverts commit 107a84e61cdd3406c842a0e4be7efffd3a05dba6.

    Meelis Roos reports a regression since 3.5-rc5 that stops Sun Fire V100
    and Sun Netra X1 sparc64 machines from booting, hanging after enabling
    serial console.  He bisected it to commit 107a84e61cdd.

    Rob Herring explains:
     "The problem is match combinations of compatible plus name and/or type
      fail to match correctly.  I have a fix for this, but given how late it
      is for 3.5 I think it is best to revert this for now.  There could be
      other cases that rely on the current although wrong behavior.  I will
      post an updated version for 3.6."

    Bisected-and-reported-by: Meelis Roos <mroos@linux.ee>
    Requested-by: Rob Herring <rob.herring@calxeda.com>
    Cc: Thierry Reding <thierry.reding@avionic-design.de>
    Cc: Grant Likely <grant.likely@secretlab.ca>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

So if Meelis still has access to the Sun Fire V100 and Sun Netra X1
machines that regressed last time around, it'd be great to get this
patch tested on them to verify that it indeed fixes the problem and
doesn't regress.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131204/0c5d7f94/attachment.sig>
