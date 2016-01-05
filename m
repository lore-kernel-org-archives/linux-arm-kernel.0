From: jolsa@redhat.com (Jiri Olsa)
Date: Tue, 5 Jan 2016 10:09:03 +0100
Subject: [RFC PATCH] arm64: perf test: Improbe bp_signal
In-Reply-To: <1451969880-14877-1-git-send-email-wangnan0@huawei.com>
References: <20160104165535.GI1616@arm.com>
 <1451969880-14877-1-git-send-email-wangnan0@huawei.com>
Message-ID: <20160105090903.GD2192@krava.brq.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 05, 2016 at 04:58:00AM +0000, Wang Nan wrote:

SNIP

>  	 * Following processing should happen:
> @@ -141,6 +203,21 @@ int test__bp_signal(int subtest __maybe_unused)
>  	 *   - fd1 event breakpoint hit -> count1 == 1
>  	 *   - SIGIO is delivered       -> overflows == 1
>  	 *   - fd2 event breakpoint hit -> count2 == 1
> +	 *   - SIGUSR1 is delivered     -> overflows_2 == 1  (nested signal)
> +	 *   - sig_handler_2 return
> +	 *   - sig_handler return
> +	 *   - fd3 event watchpoint hit -> count3 == 1       (wp and bp in one insn)
> +	 *   - SIGIO is delivered       -> overflows == 2
> +	 *   - fd2 event breakpoint hit -> count2 == 2
> +	 *   - SIGUSR1 is delivered     -> overflows_2 == 2
> +	 *   - sig_handler_2 return
> +	 *   - sig_handler return
> +	 *   - fd3 event watchpoint hit -> count3 == 2       (standalone wp)
> +	 *   - SIGIO is delivered       -> overflows = 3
> +	 *   - fd2 event breakpoint hit -> count2 == 3
> +	 *   - SIGUSR1 is delivered     -> overflows_2 == 3
> +	 *   - sig_handler_2 return
> +	 *   - sig_handler return

also each line in here could be prefixed with 'code action'
that led to the result on the line, like:


         * exec:              result:
         *
  	 * __test_function  - fd1 event breakpoint hit -> count1 == 1
         *                  - SIGIO is delivered       -> overflows == 1
         * sig_handler      - fd2 event breakpoint hit -> count2 == 1
         *                  - SIGUSR1 is delivered     -> overflows_2 == 1  (nested signal)
         *                  - sig_handler_2 return
         *                  - sig_handler return
         * incq (%rdi)      - fd3 event watchpoint hit -> count3 == 1       (wp and bp in one insn)
         *                  - SIGIO is delivered       -> overflows == 2


hum.. but it might take all the fun out of it ;-)

jirka
