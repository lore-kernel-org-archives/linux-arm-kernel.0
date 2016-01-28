From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Thu, 28 Jan 2016 14:30:51 +0200
Subject: [PATCH v6] kernel: add kcov code coverage
In-Reply-To: <1453726850-49137-1-git-send-email-dvyukov@google.com>
References: <1453726850-49137-1-git-send-email-dvyukov@google.com>
Message-ID: <87si1h6g3o.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dmitry Vyukov <dvyukov@google.com> writes:

> +	fd = open("/sys/kernel/debug/kcov", O_RDWR);
> +	if (fd == -1)
> +		perror("open"), exit(1);
> +	/* Setup trace mode and trace size. */
> +	if (ioctl(fd, KCOV_INIT_TRACE, COVER_SIZE))
> +		perror("ioctl"), exit(1);
> +	/* Mmap buffer shared between kernel- and user-space. */
> +	cover = (unsigned long*)mmap(NULL, COVER_SIZE * sizeof(unsigned long),
> +				     PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
> +	if ((void*)cover == MAP_FAILED)
> +		perror("mmap"), exit(1);
> +	/* Enable coverage collection on the current thread. */
> +	if (ioctl(fd, KCOV_ENABLE, 0))
> +		perror("ioctl"), exit(1);
> +	/* Reset coverage from the tail of the ioctl() call. */
> +	__atomic_store_n(&cover[0], 0, __ATOMIC_RELAXED);
> +	/* That's the target syscal call. */
> +	read(-1, NULL, 0);
> +	/* Read number of PCs collected. */
> +	n = __atomic_load_n(&cover[0], __ATOMIC_RELAXED);
> +	for (i = 0; i < n; i++)
> +		printf("0x%lx\n", cover[i + 1]);

Kirill is right, this does look a lot like a candidate for a perf
pmu. Most of the legwork that you do in this patch is already taken care
of by perf afaict: enabling/disabling, context tracking, ring buffer for
exporting data to userspace. You'll also get other things like privilege
separation for free.

Moreover, this can already be achieved by means of hardware assisted
instruction tracing such as BTS or PT on Intel cpus (BTS will literally
output instruction pointer addresses into a ring buffer). ARM Coresight
ETM/PTM support is also on its way. That's not to say that this work is
not useful (and it's gotta be, or who will be the one to debug the
debugger), but more to make a case for a perf-based implementation.

Regards,
--
Alex
