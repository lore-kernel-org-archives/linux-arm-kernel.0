From: rabin@rab.in (Rabin Vincent)
Date: Wed, 12 Oct 2011 22:03:34 +0530
Subject: [PATCH] [RFC PATCH] ARM: kprobes: Make breakpoint
	setting/clearing SMP safe
In-Reply-To: <1310474402-5398-1-git-send-email-tixy@yxit.co.uk>
References: <1310474402-5398-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <CAH+eYFDSG=npBEjEgObqg+vPk8QuJBnnnGyULk9s-C9Bq3iH8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 12, 2011 at 18:10, Tixy <tixy@yxit.co.uk> wrote:
> Both these issues are known and the kprobe implementation uses
> stop_machine() to avoid them, however, this is not sufficient.
> stop_machine() does not perform any kind on synchronisation between CPUs
> so it it still possible for one CPU to call the breakpoint changing
> function before another CPU has been interrupted to do likewise.
>
> To fix this problem, this patch creates a new function
> sync_stop_machine() which ensures that all online CPUs execute the
> specified function at the same time.

AFAICS stop_machine() already does what you want.  When you use
stop_machine(), the actual call to your function is done (on each
CPU's stopper thread) using the stop_machine_cpu_stop() function,
which already has the synchronization between CPUs which you're
trying to do here.
