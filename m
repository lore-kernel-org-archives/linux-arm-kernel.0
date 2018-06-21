From: rostedt@goodmis.org (Steven Rostedt)
Date: Thu, 21 Jun 2018 12:50:25 -0400
Subject: [PATCH] ARM: ftrace: Only set kernel memory back to read-only
 after boot
In-Reply-To: <20180621124710.453ee0ae@gandalf.local.home>
References: <20180621124710.453ee0ae@gandalf.local.home>
Message-ID: <20180621125025.25b70bb9@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 21 Jun 2018 12:47:10 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> Dynamic ftrace requires modifying the code segments that are usually
> set to read-only. To do this, a per arch function is called both before
> and after the ftrace modifications are performed. The "before" function
> will set kernel code text to read-write to allow for ftrace to make the
> modifications, and the "after" function will set the kernel code text
> back to "read-only" to keep the kernel code text protected.
> 
> The issue happens when dynamic ftrace is tested at boot up. The test is
> done before the kernel code text has been set to read-only. But the
> "before" and "after" calls are still performed. The "after" call will
> change the kernel code text to read-only prematurely, and other boot
> code that expects this code to be read-write will fail.
> 
> The solution is to add a variable that is set when the kernel code text
> is expected to be converted to read-only, and make the ftrace "before"
> and "after" calls do nothing if that variable is not yet set. This is
> similar to the x86 solution from commit 162396309745 ("ftrace, x86:
> make kernel text writable only for conversions").
> 
> Reported-by: Stefan Agner <stefan@agner.ch>
> Tested-by: Stefan Agner <stefan@agner.ch>
> Link: http://lkml.kernel.org/r/20180620212906.24b7b66e at vmware.local.home
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---

Perhaps I should have Cc'd stable too?

-- Steve
