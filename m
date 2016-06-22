From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Wed, 22 Jun 2016 08:56:04 +0300
Subject: [PATCH V2 1/4] trace: Introduce an output interface from ftrace
 to STM
In-Reply-To: <1466563613-31578-2-git-send-email-zhang.chunyan@linaro.org>
References: <1466563613-31578-1-git-send-email-zhang.chunyan@linaro.org>
 <1466563613-31578-2-git-send-email-zhang.chunyan@linaro.org>
Message-ID: <87mvmdu5qj.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[adding Felipe for his sudden interest in the subject matter]

Chunyan Zhang <zhang.chunyan@linaro.org> writes:

> +static struct stm_ftrace *trace_output;

What you want is a possibility to have different ftrace outputs, not
different STM outputs for ftrace (again, STM core already does this).
In other words, here, you want to have the notion of "output" be
stm-agnostic, but be a generalized output driver object.

> +
> +void trace_func_to_stm(unsigned long ip, unsigned long parent_ip)
> +{
> +	unsigned long ip_array[2] = {ip, parent_ip};
> +
> +	if (trace_output)
> +		trace_output->write(&trace_output->data, (char *)ip_array,
> +				    sizeof(unsigned long) * 2, STM_FTRACE_CHAN);
> +}

The ip+parent_ip pair is still not a useful output from ftrace
data. Moreover, doing this is basically like inventing another binary
protocol for ftrace data over stm, where ftrace is in and of itself
already a binary protocol, why not just use that? The decoder will
basically depend on the kernel binary from whence the traces are
coming, but this is a requirement even if we want to decypher the
ip+parent_ip data you're proposing.

We would need to take some time to think this through. What we might
consider is:

 * bypassing ftrace ring buffer, sending data directly to an "output",
   which has a drawback of ending up in a driver callback, which needs
   to serialize on its driver stuff and write registers (I did try to
   make stm_write as light as possible when I wrote it, though); the
   good part is that data goes into the wire as soon as it is produced
   instead of being buffered along the way;
 * starting a work (or multiple works) that would traverse new data in
   ftrace buffer and feed it to an "output", such as stm; this has a
   problem of producers being potentially faster than consumers
   (consider 'function' tracer, for example) and hogging the cpus by
   simply exporting trace data; this also botches the stm timestamps,
   which will then be representative of nothing in particular.

> +
> +void trace_add_output(struct stm_ftrace *stm)
> +{
> +	trace_output = stm;
> +}
> +EXPORT_SYMBOL_GPL(trace_add_output);
> +
> +void trace_rm_output(void)
> +{
> +	trace_output = NULL;
> +}
> +EXPORT_SYMBOL_GPL(trace_rm_output);

These, of course, only work because they are implicitly serialized on
stm core's link locks.

Regards,
--
Alex
