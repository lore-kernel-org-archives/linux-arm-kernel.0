From: lkp@intel.com (kbuild test robot)
Date: Sun, 25 Feb 2018 19:53:18 +0800
Subject: [PATCH 1/3] ftrace: Add module to ftrace_make_call() parameters
In-Reply-To: <20180223165849.16388-2-alexander.sverdlin@nokia.com>
References: <20180223165849.16388-2-alexander.sverdlin@nokia.com>
Message-ID: <201802251921.WbGsV736%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexander,

I love your patch! Yet something to improve:

[auto build test ERROR on tip/perf/core]
[also build test ERROR on v4.16-rc2 next-20180223]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Alexander-Sverdlin/ARM-Implement-MODULE_PLT-support-in-FTRACE/20180225-191957
config: x86_64-randconfig-x011-201808 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All error/warnings (new ones prefixed by >>):

   kernel/trace/ftrace.c: In function 'ftrace_module_enable':
>> kernel/trace/ftrace.c:5851:39: error: passing argument 1 of '__ftrace_replace_code' from incompatible pointer type [-Werror=incompatible-pointer-types]
       int failed = __ftrace_replace_code(rec, 1);
                                          ^~~
   kernel/trace/ftrace.c:2424:1: note: expected 'struct module *' but argument is of type 'struct dyn_ftrace *'
    __ftrace_replace_code(struct module *mod, struct dyn_ftrace *rec, int enable)
    ^~~~~~~~~~~~~~~~~~~~~
>> kernel/trace/ftrace.c:5851:44: warning: passing argument 2 of '__ftrace_replace_code' makes pointer from integer without a cast [-Wint-conversion]
       int failed = __ftrace_replace_code(rec, 1);
                                               ^
   kernel/trace/ftrace.c:2424:1: note: expected 'struct dyn_ftrace *' but argument is of type 'int'
    __ftrace_replace_code(struct module *mod, struct dyn_ftrace *rec, int enable)
    ^~~~~~~~~~~~~~~~~~~~~
>> kernel/trace/ftrace.c:5851:17: error: too few arguments to function '__ftrace_replace_code'
       int failed = __ftrace_replace_code(rec, 1);
                    ^~~~~~~~~~~~~~~~~~~~~
   kernel/trace/ftrace.c:2424:1: note: declared here
    __ftrace_replace_code(struct module *mod, struct dyn_ftrace *rec, int enable)
    ^~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/__ftrace_replace_code +5851 kernel/trace/ftrace.c

93eb677d Steven Rostedt           2009-04-15  5797  
7dcd182b Jessica Yu               2016-02-16  5798  void ftrace_module_enable(struct module *mod)
b7ffffbb Steven Rostedt (Red Hat  2016-01-07  5799) {
b7ffffbb Steven Rostedt (Red Hat  2016-01-07  5800) 	struct dyn_ftrace *rec;
b7ffffbb Steven Rostedt (Red Hat  2016-01-07  5801) 	struct ftrace_page *pg;
b7ffffbb Steven Rostedt (Red Hat  2016-01-07  5802) 
b7ffffbb Steven Rostedt (Red Hat  2016-01-07  5803) 	mutex_lock(&ftrace_lock);
b7ffffbb Steven Rostedt (Red Hat  2016-01-07  5804) 
b7ffffbb Steven Rostedt (Red Hat  2016-01-07  5805) 	if (ftrace_disabled)
b7ffffbb Steven Rostedt (Red Hat  2016-01-07  5806) 		goto out_unlock;
b7ffffbb Steven Rostedt (Red Hat  2016-01-07  5807) 
b7ffffbb Steven Rostedt (Red Hat  2016-01-07  5808) 	/*
b7ffffbb Steven Rostedt (Red Hat  2016-01-07  5809) 	 * If the tracing is enabled, go ahead and enable the record.
b7ffffbb Steven Rostedt (Red Hat  2016-01-07  5810) 	 *
b7ffffbb Steven Rostedt (Red Hat  2016-01-07  5811) 	 * The reason not to enable the record immediatelly is the
b7ffffbb Steven Rostedt (Red Hat  2016-01-07  5812) 	 * inherent check of ftrace_make_nop/ftrace_make_call for
b7ffffbb Steven Rostedt (Red Hat  2016-01-07  5813) 	 * correct previous instructions.  Making first the NOP
b7ffffbb Steven Rostedt (Red Hat  2016-01-07  5814) 	 * conversion puts the module to the correct state, thus
b7ffffbb Steven Rostedt (Red Hat  2016-01-07  5815) 	 * passing the ftrace_make_call check.
b7ffffbb Steven Rostedt (Red Hat  2016-01-07  5816) 	 *
b7ffffbb Steven Rostedt (Red Hat  2016-01-07  5817) 	 * We also delay this to after the module code already set the
b7ffffbb Steven Rostedt (Red Hat  2016-01-07  5818) 	 * text to read-only, as we now need to set it back to read-write
b7ffffbb Steven Rostedt (Red Hat  2016-01-07  5819) 	 * so that we can modify the text.
b7ffffbb Steven Rostedt (Red Hat  2016-01-07  5820) 	 */
b7ffffbb Steven Rostedt (Red Hat  2016-01-07  5821) 	if (ftrace_start_up)
b7ffffbb Steven Rostedt (Red Hat  2016-01-07  5822) 		ftrace_arch_code_modify_prepare();
b7ffffbb Steven Rostedt (Red Hat  2016-01-07  5823) 
b7ffffbb Steven Rostedt (Red Hat  2016-01-07  5824) 	do_for_each_ftrace_rec(pg, rec) {
b7ffffbb Steven Rostedt (Red Hat  2016-01-07  5825) 		int cnt;
b7ffffbb Steven Rostedt (Red Hat  2016-01-07  5826) 		/*
b7ffffbb Steven Rostedt (Red Hat  2016-01-07  5827) 		 * do_for_each_ftrace_rec() is a double loop.
b7ffffbb Steven Rostedt (Red Hat  2016-01-07  5828) 		 * module text shares the pg. If a record is
b7ffffbb Steven Rostedt (Red Hat  2016-01-07  5829) 		 * not part of this module, then skip this pg,
b7ffffbb Steven Rostedt (Red Hat  2016-01-07  5830) 		 * which the "break" will do.
b7ffffbb Steven Rostedt (Red Hat  2016-01-07  5831) 		 */
3e234289 Steven Rostedt (VMware   2017-03-03  5832) 		if (!within_module_core(rec->ip, mod) &&
3e234289 Steven Rostedt (VMware   2017-03-03  5833) 		    !within_module_init(rec->ip, mod))
b7ffffbb Steven Rostedt (Red Hat  2016-01-07  5834) 			break;
b7ffffbb Steven Rostedt (Red Hat  2016-01-07  5835) 
b7ffffbb Steven Rostedt (Red Hat  2016-01-07  5836) 		cnt = 0;
b7ffffbb Steven Rostedt (Red Hat  2016-01-07  5837) 
b7ffffbb Steven Rostedt (Red Hat  2016-01-07  5838) 		/*
b7ffffbb Steven Rostedt (Red Hat  2016-01-07  5839) 		 * When adding a module, we need to check if tracers are
b7ffffbb Steven Rostedt (Red Hat  2016-01-07  5840) 		 * currently enabled and if they are, and can trace this record,
b7ffffbb Steven Rostedt (Red Hat  2016-01-07  5841) 		 * we need to enable the module functions as well as update the
b7ffffbb Steven Rostedt (Red Hat  2016-01-07  5842) 		 * reference counts for those function records.
b7ffffbb Steven Rostedt (Red Hat  2016-01-07  5843) 		 */
b7ffffbb Steven Rostedt (Red Hat  2016-01-07  5844) 		if (ftrace_start_up)
b7ffffbb Steven Rostedt (Red Hat  2016-01-07  5845) 			cnt += referenced_filters(rec);
b7ffffbb Steven Rostedt (Red Hat  2016-01-07  5846) 
b7ffffbb Steven Rostedt (Red Hat  2016-01-07  5847) 		/* This clears FTRACE_FL_DISABLED */
b7ffffbb Steven Rostedt (Red Hat  2016-01-07  5848) 		rec->flags = cnt;
b7ffffbb Steven Rostedt (Red Hat  2016-01-07  5849) 
b7ffffbb Steven Rostedt (Red Hat  2016-01-07  5850) 		if (ftrace_start_up && cnt) {
b7ffffbb Steven Rostedt (Red Hat  2016-01-07 @5851) 			int failed = __ftrace_replace_code(rec, 1);
b7ffffbb Steven Rostedt (Red Hat  2016-01-07  5852) 			if (failed) {
b7ffffbb Steven Rostedt (Red Hat  2016-01-07  5853) 				ftrace_bug(failed, rec);
b7ffffbb Steven Rostedt (Red Hat  2016-01-07  5854) 				goto out_loop;
b7ffffbb Steven Rostedt (Red Hat  2016-01-07  5855) 			}
b7ffffbb Steven Rostedt (Red Hat  2016-01-07  5856) 		}
b7ffffbb Steven Rostedt (Red Hat  2016-01-07  5857) 
b7ffffbb Steven Rostedt (Red Hat  2016-01-07  5858) 	} while_for_each_ftrace_rec();
b7ffffbb Steven Rostedt (Red Hat  2016-01-07  5859) 
b7ffffbb Steven Rostedt (Red Hat  2016-01-07  5860)  out_loop:
b7ffffbb Steven Rostedt (Red Hat  2016-01-07  5861) 	if (ftrace_start_up)
b7ffffbb Steven Rostedt (Red Hat  2016-01-07  5862) 		ftrace_arch_code_modify_post_process();
b7ffffbb Steven Rostedt (Red Hat  2016-01-07  5863) 
b7ffffbb Steven Rostedt (Red Hat  2016-01-07  5864)  out_unlock:
b7ffffbb Steven Rostedt (Red Hat  2016-01-07  5865) 	mutex_unlock(&ftrace_lock);
d7fbf8df Steven Rostedt (VMware   2017-06-26  5866) 
d7fbf8df Steven Rostedt (VMware   2017-06-26  5867) 	process_cached_mods(mod->name);
b7ffffbb Steven Rostedt (Red Hat  2016-01-07  5868) }
b7ffffbb Steven Rostedt (Red Hat  2016-01-07  5869) 

:::::: The code at line 5851 was first introduced by commit
:::::: b7ffffbb46f205e7727a18bcc7a46c3c2b534f7c ftrace: Add infrastructure for delayed enabling of module functions

:::::: TO: Steven Rostedt (Red Hat) <rostedt@goodmis.org>
:::::: CC: Steven Rostedt <rostedt@goodmis.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 27148 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180225/10b295a5/attachment-0001.gz>
