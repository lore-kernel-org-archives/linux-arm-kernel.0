From: dsahern@gmail.com (David Ahern)
Date: Wed, 21 Jan 2015 15:00:15 -0700
Subject: [PATCH 2/2] perf symbols: debuglink should take symfs option
 into account
In-Reply-To: <CAA3XUr1BnS=8RTVyxtVOm4Ahb2DQXUuJJQC1w2SvT5fycjRcEQ@mail.gmail.com>
References: <1421168344-5363-1-git-send-email-victor.kamensky@linaro.org>	<1421168344-5363-2-git-send-email-victor.kamensky@linaro.org>
 <CAA3XUr1BnS=8RTVyxtVOm4Ahb2DQXUuJJQC1w2SvT5fycjRcEQ@mail.gmail.com>
Message-ID: <54C0216F.3080404@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/19/15 10:50 AM, Victor Kamensky wrote:
>> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
>> index 45be944..6a2f663 100644
>> --- a/tools/perf/util/dso.c
>> +++ b/tools/perf/util/dso.c
>> @@ -42,19 +42,30 @@ int dso__read_binary_type_filename(const struct dso *dso,
>>          size_t len;
>>
>>          switch (type) {
>> -       case DSO_BINARY_TYPE__DEBUGLINK: {
>> +       case DSO_BINARY_TYPE__DEBUGLINK:
>> +       {
>>                  char *debuglink;
>> -
>> -               strncpy(filename, dso->long_name, size);
>> -               debuglink = filename + dso->long_name_len;
>> -               while (debuglink != filename && *debuglink != '/')
>> -                       debuglink--;
>> -               if (*debuglink == '/')
>> -                       debuglink++;
>> -               ret = filename__read_debuglink(dso->long_name, debuglink,
>> -                                              size - (debuglink - filename));
>> -               }
>> +               char *filename_copy;
>> +
>> +               filename_copy = malloc(PATH_MAX);
>> +               if (filename_copy) {
>> +                       len = __symbol__join_symfs(filename, size,
>> +                                                  dso->long_name);
>> +                       strncpy(filename_copy, filename, PATH_MAX);
>> +                       debuglink = filename + len;
>> +                       while (debuglink != filename && *debuglink != '/')
>> +                               debuglink--;
>> +                       if (*debuglink == '/')
>> +                               debuglink++;
>> +                       ret = filename__read_debuglink(filename_copy, debuglink,
>> +                                                      size - (debuglink -
>> +                                                              filename));
>> +                       free(filename_copy);
>> +               } else
>> +                       ret = -1;
>>                  break;
>> +       }
>> +

I do not believe the filename_copy is needed; just add the symfs path to 
filename and pass filename to read_debuglink

David
