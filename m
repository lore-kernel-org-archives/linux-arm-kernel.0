From: peterz@infradead.org (Peter Zijlstra)
Date: Mon, 2 Mar 2015 13:31:49 +0100
Subject: PMD update corruption (sync question)
In-Reply-To: <1172437505.28092883.1425294374323.JavaMail.zimbra@zmail15.collab.prod.int.phx2.redhat.com>
References: <1411740233-28038-1-git-send-email-steve.capper@linaro.org>
 <54F06636.6080905@redhat.com> <54F3C6AD.50300@redhat.com>
 <938476184.27970130.1425275915893.JavaMail.zimbra@zmail15.collab.prod.int.phx2.redhat.com>
 <20150302105011.GD22541@e104818-lin.cambridge.arm.com>
 <1172437505.28092883.1425294374323.JavaMail.zimbra@zmail15.collab.prod.int.phx2.redhat.com>
Message-ID: <20150302123149.GK21418@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 02, 2015 at 06:06:14AM -0500, Jon Masters wrote:

> 64-bit writes are /usually/ atomic but alignment or compiler emiting
> 32-bit opcodes could also do it. I agree there are a few other pieces
> to this we will chat about separately and come back to this thread.

Looking at the asm will quickly tell you if its emitting 32bit stores or
not. If it is, use WRITE_ONCE() (you should anyway I suppose) and see if
that cures it, if not file a compiler bug, volatile stores should never
be split.

As to alignment, you can simply put a BUG_ON((unsigned long)ptep & 7);
in there.

Also:

A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?
