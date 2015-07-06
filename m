From: panand@redhat.com (Pratyush Anand)
Date: Mon, 6 Jul 2015 17:19:20 +0530
Subject: [PATCH 1/2] arm64: Blacklist non-kprobe-able symbols
In-Reply-To: <559A6257.60608@hitachi.com>
References: <cover.1436158027.git.panand@redhat.com>
 <9994841a0b0a8194a6dcc1b6af148ba358488c62.1436158027.git.panand@redhat.com>
 <559A6257.60608@hitachi.com>
Message-ID: <20150706114920.GB17305@dhcppc13.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/07/2015:08:11:19 PM, Masami Hiramatsu wrote:
> On 2015/07/06 14:03, Pratyush Anand wrote:
> > Add all function symbols which are called from do_debug_exception under
> > NOKPROBE_SYMBOL, as they can not kprobed.
> 
> Could you tell me how you checked that? from the code?

Well.. I found out that some of the symbol like single_step_handler
does not allow kprobing, and then it seemed logical to me that we
should not allow kprobing of any symbols which are called in the path
of do_debug_exception. So, manually :( I reviewed the code and put
NOKPROBE_SYMBOL across all those.

However, now I am doing some more tests  and as I said in previous
reply, there are still few symbols like (_mcount) which is creating
problem with following simple test and I need to look into that. In
case of _mcount, I do not see any print and its complete freeze.

#!/bin/sh
grep ' [tT] ' /proc/kallsyms | fgrep -v '[' | awk '{print $3}' > syms.list
count=0
for i in `cat syms.list`;
do
	if [ $count == 0 ]
	then
    		echo 0 > /sys/kernel/debug/tracing/events/enable
		echo > /sys/kernel/debug/tracing/kprobe_events
		cat /sys/kernel/debug/tracing/kprobe_events
	fi
	count=`expr $count + 1`;
	echo "p $i" >> /sys/kernel/debug/tracing/kprobe_events ;
	echo $i $count;
	if [ $count == 100 ]
	then
		cat /sys/kernel/debug/tracing/kprobe_events
		echo 1 >  /sys/kernel/debug/tracing/events/enable
		sleep 1
		cat /sys/kernel/debug/tracing/trace
		count=0
	fi
done

I understand that above test does not make sure that kprobed function
is called during test. Since at present this basic test is not
running, so I am not doing anything to exercise more and more kernel
paths.  May be I will do that as second step..In fact at present, no
idea how can be done that extensively.

~Pratyush
