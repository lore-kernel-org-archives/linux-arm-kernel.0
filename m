From: viro@ZenIV.linux.org.uk (Al Viro)
Date: Thu, 6 Oct 2016 23:41:17 +0100
Subject: [PATCH] Revert "debugfs: ->d_parent is never NULL or negative"
In-Reply-To: <20161006223729.GO19539@ZenIV.linux.org.uk>
References: <1475789429-11414-1-git-send-email-okaya@codeaurora.org>
 <20161006213734.GM19539@ZenIV.linux.org.uk>
 <f6ba2bf7-4f0b-e874-d642-6620d5df2212@codeaurora.org>
 <20161006220050.GN19539@ZenIV.linux.org.uk>
 <20161006223729.GO19539@ZenIV.linux.org.uk>
Message-ID: <20161006224117.GP19539@ZenIV.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 06, 2016 at 11:37:29PM +0100, Al Viro wrote:

> If you ever get NULL in ->d_parent of struct dentry instance, you are
> practically certain to have a dangling pointer to memory that used to
> contain a struct dentry at some point but got freed and reused since then.

... which is what happens in your case, apparently.  ->stats is still
pointing to a dentry that had just been freed and its memory reused.
