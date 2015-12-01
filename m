From: akpm@linux-foundation.org (Andrew Morton)
Date: Mon, 30 Nov 2015 16:18:11 -0800
Subject: [PATCH v4 1/4] mm: mmap: Add new /proc tunable for mmap_base ASLR.
In-Reply-To: <CAGXu5jK7UzjBxXKQajxhLv-uLk_xQXR_FHOsmW6RLJNeK_-dZg@mail.gmail.com>
References: <1448578785-17656-1-git-send-email-dcashman@android.com>
 <1448578785-17656-2-git-send-email-dcashman@android.com>
 <20151130155412.b1a087f4f6f4d4180ab4472d@linux-foundation.org>
 <20151130160118.e43a2e53a59e347a95a94d5c@linux-foundation.org>
 <CAGXu5jK7UzjBxXKQajxhLv-uLk_xQXR_FHOsmW6RLJNeK_-dZg@mail.gmail.com>
Message-ID: <20151130161811.592c205d8dc7b00f44066a37@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 30 Nov 2015 16:04:36 -0800 Kees Cook <keescook@chromium.org> wrote:

> >> > +#ifdef CONFIG_HAVE_ARCH_MMAP_RND_BITS
> >> > +   {
> >> > +           .procname       = "mmap_rnd_bits",
> >> > +           .data           = &mmap_rnd_bits,
> >> > +           .maxlen         = sizeof(mmap_rnd_bits),
> >> > +           .mode           = 0600,
> >> > +           .proc_handler   = proc_dointvec_minmax,
> >> > +           .extra1         = (void *) &mmap_rnd_bits_min,
> >> > +           .extra2         = (void *) &mmap_rnd_bits_max,
> >>
> >> hm, why the typecasts?  They're unneeded and are omitted everywhere(?)
> >> else in kernel/sysctl.c.
> >
> > Oh.  Casting away constness.
> >
> > What's the thinking here?  They can change at any time so they aren't
> > const so we shouldn't declare them to be const?
> 
> The _min and _max values shouldn't be changing: they're decided based
> on the various CONFIG options that calculate the valid min/maxes. Only
> mmap_rnd_bits itself should be changing.

hmpf.

From: Andrew Morton <akpm@linux-foundation.org>
Subject: include/linux/sysctl.h: make ctl_table.extra1/2 const

Nothing should be altering these values.  Declare the pointed-to values to
be const so we can actually use const values.

Cc: Kees Cook <keescook@chromium.org>
Cc: Daniel Cashman <dcashman@android.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/linux/sysctl.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -puN include/linux/sysctl.h~a include/linux/sysctl.h
--- a/include/linux/sysctl.h~a
+++ a/include/linux/sysctl.h
@@ -111,8 +111,8 @@ struct ctl_table
 	struct ctl_table *child;	/* Deprecated */
 	proc_handler *proc_handler;	/* Callback for text formatting */
 	struct ctl_table_poll *poll;
-	void *extra1;
-	void *extra2;
+	const void *extra1;
+	const void *extra2;
 };
 
 struct ctl_node {
diff -puN kernel/sysctl.c~a kernel/sysctl.c
_
