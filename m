From: adrian.wenl@gmail.com (Lei Wen)
Date: Thu, 29 Dec 2011 16:38:03 +0800
Subject: ftrace performance impact with different configuration
Message-ID: <CALZhoSRVNp=Sj2u2GHiQhuHOEdrfiM58KzG+RutvJV=8CoCpTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Since we all know tracing is a good toy to play, but enable it in the
defconfig would introduce extra effort for
the product system. Here I test with different configuration, and
maybe someone could base my data to
further decrease system overhead when enabling it as defconfig but not
enabling it. It is most useful for product kernel,
as we could enable it latter on the fly.

I am using iperf test over one ARMv5 board with kernel 3.0. The test
environment setting as below:
For TCP testing
PC side: 	    iperf -s -f m -w 128k
Board side:    iperf -c 192.168.1.100 -t 300 -i 1 -f m -r -w 128k

For UDP testing
PC side:       iperf -s -f m -u -w 128k
Board side:   iperf -c 192.168.1.100 -t 300 -i 1 -f m -r -u -b 500m -l
1470 -w 128k

The data is listed the pattern as: (sender speed/receiver speed), and
the unit is as Mbit/s
Also here ftrace enabled means we only enable the option of function
tracer and dynamic tracer
With no ftrace and no debugfs built in:     tcp: 155/188   udp: 276/197
With no ftrace but with debugfs built in:   tcp: 149/184    udp:270/187
With ftrace built in:                                tcp: 136/164
udp:254/141
With ftrace buit in but with modification:  tcp:  148/167   udp:263/174


Here the modification metioned above is:
diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index d530a44..5d51e35 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -105,7 +105,7 @@ void tracepoint_update_probe_range(struct
tracepoint * const *begin,
 #define TP_ARGS(args...)       args
 #define TP_CONDITION(args...)  args

-#ifdef CONFIG_TRACEPOINTS
+#ifndef CONFIG_TRACEPOINTS

By this modification, I suppose the tracepoint would not involve extra
performance penalty.
I do this change is for arm don't support jump label yet, and I think
the best jump label could achieve
also cannot exceed the result by this modification.

So it seems to me that:
1. tracepoint without jump label support could greatly bring down the
system performance even they are only built in but not enabled
2. Seem dynamic ftrace also could involve some penalty for the running
system, although it patching the running kernel with nop stub...

For the second item, is there anyone done some research before that
could zero the cost for the running system when the tracing is not
enabled yet?

Thanks,
Lei
