From: lkp@intel.com (kbuild test robot)
Date: Mon, 15 Aug 2016 21:03:22 +0800
Subject: [PATCH V4 1/3] tracing: add a possibility of exporting function
 trace to other places instead of ring buffer only
In-Reply-To: <1471261803-1186-2-git-send-email-zhang.chunyan@linaro.org>
Message-ID: <201608152102.m6KoaCgL%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chunyan,

[auto build test WARNING on linus/master]
[also build test WARNING on v4.8-rc2 next-20160815]
[cannot apply to linux/master]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Chunyan-Zhang/tracing-add-a-possibility-of-exporting-function-trace-to-other-places-instead-of-ring-buffer-only/20160815-195631
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   include/linux/compiler.h:230:8: sparse: attribute 'no_sanitize_address': unknown attribute
>> kernel/trace/trace.c:2173:23: sparse: incompatible types in comparison expression (different address spaces)
   kernel/trace/trace.c:2175:23: sparse: incompatible types in comparison expression (different address spaces)

vim +2173 kernel/trace/trace.c

  2157	static DEFINE_MUTEX(trace_export_lock);
  2158	
  2159	static struct trace_export trace_export_rb __read_mostly = {
  2160		.name		= "rb",
  2161		.commit	= trace_rb_commit,
  2162		.next		= NULL,
  2163	};
  2164	static struct trace_export *trace_exports_list __read_mostly = &trace_export_rb;
  2165	
  2166	inline void
  2167	trace_exports(struct trace_array *tr, struct ring_buffer_event *event)
  2168	{
  2169		struct trace_export *export;
  2170	
  2171		preempt_disable_notrace();
  2172	
> 2173		for (export = rcu_dereference_raw_notrace(trace_exports_list);
  2174		     export && export->commit;
  2175		     export = rcu_dereference_raw_notrace(export->next)) {
  2176			tr->export = export;
  2177			export->commit(tr, event);
  2178		}
  2179	
  2180		preempt_enable_notrace();
  2181	}

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
