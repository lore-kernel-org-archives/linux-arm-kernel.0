From: alison@she-devel.com (alison at she-devel.com)
Date: Wed, 18 Feb 2015 23:19:49 -0800
Subject: [PATCH v3 0/1] i.MX6: WEIM: improve error handling upon child
 probe-failure
In-Reply-To: <21911320.10lVZQzK19@jclayton-pc>
References: <21911320.10lVZQzK19@jclayton-pc>
Message-ID: <1424330390-8373-1-git-send-email-alison_chaiken@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alison Chaiken <alison_chaiken@mentor.com>

Here is a third version which incorporates Joshua Clayton's suggestions.
The boolean value have_child is initialized to zero and the redundant
return statement is removed.

Joshua inquires:
>There is no explicit of_node_get(), at least at this level, so the need
>for the original patch is not entirely clear to me.

for_each_child_of_node() calls of_get_next_child() which in turn calls
of_node_get().  If the for_each_child_of_node() iterator runs to the
end of the list, the last call of of_get_next_child() puts the final
open reference.  If the iterator loop is exited early due to an
error,the final reference needs to be cleaned up manually.  Since, in
the last two versions, failure of a child probe results in a warning
rather than a loop exit, there is no longer a dangling reference.

Alison Chaiken (1):
  i.MX6: WEIM: improve error handling upon child probe-failure

 drivers/bus/imx-weim.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

-- 
2.1.4
