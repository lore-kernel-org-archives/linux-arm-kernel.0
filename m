From: john.garry@huawei.com (John Garry)
Date: Tue, 13 Mar 2018 09:36:03 +0000
Subject: [PATCH v3 04/11] perf vendor events: add support for pmu events
 vendor subdirectory
In-Reply-To: <20180312182827.GA10004@kernel.org>
References: <1520506716-197429-1-git-send-email-john.garry@huawei.com>
 <1520506716-197429-5-git-send-email-john.garry@huawei.com>
 <20180312182827.GA10004@kernel.org>
Message-ID: <c6ee2344-913a-ef6c-e33e-c553ade71fa4@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/03/2018 18:28, Arnaldo Carvalho de Melo wrote:
> Em Thu, Mar 08, 2018 at 06:58:29PM +0800, John Garry escreveu:
>> index 1d02faf..7b9e210 100644
>> --- a/tools/perf/pmu-events/jevents.c
>> @@ -739,25 +739,77 @@ static int get_maxfds(void)
>>  static FILE *eventsfp;
>>  static char *mapfile;
>>
>> +static int is_leaf_dir(const char *fpath)
>> +{
>> +	DIR *d;
>> +	struct dirent *dir;
>> +	int res = 1;
>> +
>> +	d = opendir(fpath);
>> +	if (!d)
>> +		return 0;
>> +
>> +	while ((dir = readdir(d)) != NULL) {
>> +		if (dir->d_type == DT_DIR && dir->d_name[0] != '.') {
>> +			res = 0;
>> +			break;
>> +		} else if (dir->d_type == DT_UNKNOWN) {
>> +			char path[PATH_MAX];
>
>
> You forgot to add:
>
> #include <limits.h>
>
> Which broke the build on at least:
>
> [root at jouet ~]# time dm
>    1    13.78 alpine:3.4                    : FAIL gcc (Alpine 5.3.0) 5.3.0
>    2    14.40 alpine:3.5                    : FAIL gcc (Alpine 6.2.1) 6.2.1 20160822
>    3    13.59 alpine:3.6                    : FAIL gcc (Alpine 6.3.0) 6.3.0
>    4    14.94 alpine:3.7                    : FAIL gcc (Alpine 6.4.0) 6.4.0
>    5    14.70 alpine:edge                   : FAIL gcc (Alpine 6.4.0) 6.4.0
>    6: amazonlinux:1^C^C
>
> I just fixed it.
>
> build failure:
>
>   MKDIR    /tmp/build/perf/pmu-events/
>   HOSTCC   /tmp/build/perf/pmu-events/json.o
>   MKDIR    /tmp/build/perf/pmu-events/
>   HOSTCC   /tmp/build/perf/pmu-events/jsmn.o
>   HOSTCC   /tmp/build/perf/pmu-events/jevents.o
>   LD       /tmp/build/perf/libtraceevent-in.o
>   LINK     /tmp/build/perf/libtraceevent.a
>   LD       /tmp/build/perf/libsubcmd-in.o
>   CC       /tmp/build/perf/plugin_jbd2.o
>   CC       /tmp/build/perf/plugin_hrtimer.o
> pmu-events/jevents.c: In function 'is_leaf_dir':
> pmu-events/jevents.c:879:14: error: 'PATH_MAX' undeclared (first use in this function)
>     char path[PATH_MAX];
>               ^~~~~~~~
> pmu-events/jevents.c:879:14: note: each undeclared identifier is reported only once for each function it appears in
>   AR       /tmp/build/perf/libsubcmd.a
> mv: can't rename '/tmp/build/perf/pmu-events/.jevents.o.tmp': No such file or directory
> make[3]: *** [/git/linux/tools/build/Makefile.build:96: /tmp/build/perf/pmu-events/jevents.o] Error 1
>   CC       /tmp/build/perf/plugin_kmem.o
>   LD       /tmp/build/perf/plugin_jbd2-in.o
> make[2]: *** [Makefile.perf:501: /tmp/build/perf/pmu-events/jevents-in.o] Error 2
> make[2]: *** Waiting for unfinished jobs....
>   GEN      perf-archive
>   CC       /tmp/build/perf/plugin_kvm.o
>
>
> .
>

OK, thanks for the notification.

I will check this.

All the best,
John
