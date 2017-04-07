From: drjones@redhat.com (Andrew Jones)
Date: Fri, 7 Apr 2017 16:42:34 +0200
Subject: [RFC kvm-unit-tests PATCH 5/8] Makefile: add explicit mkdir for
 .o targets
In-Reply-To: <20170406190727.5624-6-alex.bennee@linaro.org>
References: <20170406190727.5624-1-alex.bennee@linaro.org>
 <20170406190727.5624-6-alex.bennee@linaro.org>
Message-ID: <20170407144234.kmq2ofvh5e6vyssq@kamzik.brq.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 06, 2017 at 08:07:24PM +0100, Alex Benn?e wrote:
> This is fairly direct way of ensuring the target build directories are
> created before we build a binary blob. mkdir -p fails gracefully if
> the directory is already there.
> 
> Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
> ---
>  Makefile | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Makefile b/Makefile
> index 781186e..56598df 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -79,8 +79,13 @@ $(LIBFDT_archive): $(addprefix $(LIBFDT_objdir)/,$(LIBFDT_OBJS))
>  	$(AR) rcs $@ $^
>  
>  %.o: %.S
> +	mkdir -p $(dir $@)
>  	$(CC) $(CFLAGS) -c -nostdlib -o $@ $<
>  
> +%.o: %.c
> +	mkdir -p $(dir $@)
> +	$(CC) $(CFLAGS) -c -o $@ $<

This rule will override any arch makefile %.o rule.  I don't think we want
to do that.  And I guess that means we should move the '%.o: %.S' rule up
above the include $(TEST_DIR)/Makefile so we don't override those either.

> +
>  -include */.*.d */*/.*.d
>  
>  all: $(shell git -C $(SRCDIR) rev-parse --verify --short=8 HEAD >build-head 2>/dev/null)
> -- 
> 2.11.0
>

I'd prefer we just have a couple places where we do mkdir:  one in the
common Makefile for common dirs (BUILD_DIRS) and one in the arch makefile
for arch dirs (ARCH_BUILD_DIRS).

The example linked below looks like something we might be able to apply.

https://www.gnu.org/software/make/manual/html_node/Prerequisite-Types.html#Prerequisite-Types

Thanks,
drew
