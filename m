From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Sat, 15 Dec 2012 22:43:24 +0300
Subject: [RFC v2 1/1] RTL8712 alignment bug in 3.6 and up on ARMV5
In-Reply-To: <CAMW5UfZmptBK5sLq3zMdPJ6C3Arqfyy4SY5BOPfqcOB1T-sbSg@mail.gmail.com>
References: <CAMW5UfZmptBK5sLq3zMdPJ6C3Arqfyy4SY5BOPfqcOB1T-sbSg@mail.gmail.com>
Message-ID: <20121215194324.GD5032@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for fixing this bug.  Your patch works but it's not the right
way to do it.

The original code here adds 4 to pointers which are currently
aligned instead of leaving them as is.  We have a kernel ALIGN()
macro which works correctly, but actually, it's not needed.

On arm, the pointer returned from kmalloc() is already aligned at
the 8 byte boundary because "#define ARCH_SLAB_MINALIGN 8".  The
original code always adds 4 to the pointer so everything is
misaligned.

Your patch adds another 4 bytes so it is now aligned at the 8 byte
boundary again.  That works, of course, but it's better to remove
the whole mess.

	pstapriv->pallocated_stainfo_buf = kmalloc(sizeof(struct sta_info) * NUM_STA);

Get rid of the ->pstainfo_buf pointer which is only used to store
the "aligned" version of ->pallocated_stainfo_buf.

Please send a version which applies with "git am" and has the proper
sign-off.  Sent it to yourself first.  Save the raw email (including
headers and everything).
	cat raw_email.txt | git am
Type "git log -p" to verify that the commit message looks good.
Then resend it to the list.

Thanks again.  This is a good bugfix.

regards,
dan carpenter
