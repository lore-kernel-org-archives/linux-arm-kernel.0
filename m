From: john.garry@huawei.com (John Garry)
Date: Wed, 6 Dec 2017 14:41:57 +0000
Subject: [RFC PATCH 1/5] perf jevents: add support for pmu events vendor
 subdirectory
In-Reply-To: <20171206133829.GC12508@krava>
References: <1512490399-94107-1-git-send-email-john.garry@huawei.com>
 <1512490399-94107-2-git-send-email-john.garry@huawei.com>
 <20171206133829.GC12508@krava>
Message-ID: <5aaa3863-f90e-cd0e-37ee-58a8f17f6e63@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/12/2017 13:38, Jiri Olsa wrote:
> On Wed, Dec 06, 2017 at 12:13:15AM +0800, John Garry wrote:
>
> SNIP
>
>> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
>> index b578aa2..a0d489e 100644
>> --- a/tools/perf/pmu-events/jevents.c
>> +++ b/tools/perf/pmu-events/jevents.c
>> @@ -588,7 +588,7 @@ static char *file_name_to_table_name(char *fname)
>>  	 * Derive rest of table name from basename of the JSON file,
>>  	 * replacing hyphens and stripping out .json suffix.
>>  	 */
>> -	n = asprintf(&tblname, "pme_%s", basename(fname));
>> +	n = asprintf(&tblname, "pme_%s", fname);
>>  	if (n < 0) {
>>  		pr_info("%s: asprintf() error %s for file %s\n", prog,
>>  				strerror(errno), fname);
>> @@ -598,7 +598,7 @@ static char *file_name_to_table_name(char *fname)
>>  	for (i = 0; i < strlen(tblname); i++) {
>>  		c = tblname[i];
>>
>> -		if (c == '-')
>> +		if (c == '-' || c == '/')
>>  			tblname[i] = '_';
>>  		else if (c == '.') {
>>  			tblname[i] = '\0';
>> @@ -755,15 +755,52 @@ static int get_maxfds(void)
>>  static FILE *eventsfp;
>>  static char *mapfile;
>>
>> +static int isLeafDir(const char *fpath)
>
> we use _ to separate words in functions names
>

Ok (I will also check functions added elsewhere)

>> +{
>> +	DIR 		  *d;
>> +	struct dirent *dir;
>> +	int res = 1;
>> +	d = opendir(fpath);
>> +	if (!d)
>> +		return 0;
>> +
>> +	while ((dir = readdir(d)) != NULL) {
>> +		if (dir-> d_type == DT_DIR && dir->d_name[0] != '.') {
>> +			res = 0;
>> +			break;
>
> just recently got into a issue on xfs when d_type is DT_UNKNOWN
> for directory.. you need to handle it
>

Sure

Cheers,
John

> thanks,
> jirka
>
> .
>
