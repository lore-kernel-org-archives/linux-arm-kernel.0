From: pbonzini@redhat.com (Paolo Bonzini)
Date: Thu, 12 Jan 2017 18:50:00 +0100
Subject: [kvm-unit-tests PATCH 6/6] run_tests: allow passing of options to
 QEMU
In-Reply-To: <20170112173204.ufd2ggw7iz7xv772@hawk.localdomain>
References: <20170111162841.15569-1-alex.bennee@linaro.org>
 <20170111162841.15569-7-alex.bennee@linaro.org>
 <20170112173204.ufd2ggw7iz7xv772@hawk.localdomain>
Message-ID: <648638bd-a90e-ee98-337a-223ed533f53a@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/01/2017 18:32, Andrew Jones wrote:
>>  
>> +# Any options left for QEMU?
>> +shift $((OPTIND-1))
>> +if [ "$#" -gt  0 ]; then
>> +    extra_opts="$@"
>> +fi
> We can unconditionally do the extra_opts="$@", extra_opts will just
> be null in the case there aren't more args, like it was before.

extra_opts is not an array, so this would mess up options that contain
spaces.  (Alex's patch in general, not your tweak).

Paolo

>> +
>>  RUNTIME_log_stderr () { cat >> test.log; }
>>  RUNTIME_log_stdout () {
>>      if [ "$PRETTY_PRINT_STACKS" = "yes" ]; then
>> @@ -59,4 +68,4 @@ RUNTIME_log_stdout () {
>>  config=$TEST_DIR/unittests.cfg
>>  rm -f test.log
>>  printf "BUILD_HEAD=$(cat build-head)\n\n" > test.log
>> -for_each_unittest $config run
>> +for_each_unittest $config run "$extra_opts"
