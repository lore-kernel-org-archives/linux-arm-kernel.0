From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 26 Aug 2017 01:10:34 +0200
Subject: [PATCH 2/2] drivers: net: xgene: Clean up all outstanding tx
 descriptors
In-Reply-To: <1503699810-12803-3-git-send-email-isubramanian@apm.com>
References: <1503699810-12803-1-git-send-email-isubramanian@apm.com>
 <1503699810-12803-3-git-send-email-isubramanian@apm.com>
Message-ID: <20170825231034.GC4207@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 25, 2017 at 03:23:30PM -0700, Iyappan Subramanian wrote:
> When xgene_enet is rmmod'd and there are still outstanding tx descriptors
> that have been setup but have not completed, it is possible on the next
> modprobe of the driver to receive the oldest of such tx descriptors. This
> results in a kernel NULL pointer dereference.
> 
> This patch attempts to clean up (by tearing down) all outstanding tx
> descriptors when the xgene_enet driver is being rmmod'd.
> 
> Given that, on the next modprobe it should be safe to ignore any such tx
> descriptors received that map to a NULL skb pointer.

This does not sound correct. Before the module is allowed to be
removed, everything needs to be finished. You need to wait for all the
tx descriptors to be returned before unloading. How can you free the
memory for the descriptor if it is still in use? How can you free the
skbuf the descriptor points to, if it is still in use... 

      Andrew
