From: tchalamarla@caviumnetworks.com (Tirumalesh Chalamarla)
Date: Fri, 25 Sep 2015 09:31:39 -0700
Subject: [PATCH] arm64: Increase the max granular size
In-Reply-To: <20150925144516.GM1820@rric.localdomain>
References: <1442944788-17254-1-git-send-email-rric@kernel.org>
 <20150922182902.GO7356@arm.com> <20150925144516.GM1820@rric.localdomain>
Message-ID: <560576EB.2010208@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/25/2015 07:45 AM, Robert Richter wrote:
> Will,
>
> On 22.09.15 19:29:02, Will Deacon wrote:
>> On Tue, Sep 22, 2015 at 06:59:48PM +0100, Robert Richter wrote:
>>> From: Tirumalesh Chalamarla <tchalamarla@cavium.com>
>>>
>>> Increase the standard cacheline size to avoid having locks in the same
>>> cacheline.
>>>
>>> Cavium's ThunderX core implements cache lines of 128 byte size. With
>>> current granulare size of 64 bytes (L1_CACHE_SHIFT=6) two locks could
>>> share the same cache line leading a performance degradation.
>>> Increasing the size fixes that.
>> Do you have an example of that happening?
> I did some 'poor man's kernel build all modules benchmarking' and
> could not find significant performance improvements so far (second
> part with the patch reverted):
>
>   build-allmodules-4.2.0-01404-g5818d6e89783.log:real       7m10.490s
>   build-allmodules-4.2.0-01404-g5818d6e89783.log:real       6m59.747s
>   build-allmodules-4.2.0-01404-g5818d6e89783.log:real       6m59.264s
>   build-allmodules-4.2.0-01404-g5818d6e89783.log:real       7m0.435s
>   build-allmodules-4.2.0-01404-g5818d6e89783.log:real       6m59.569s
>   build-allmodules-4.2.0-01404-g5818d6e89783.log:real       6m59.274s
>   build-allmodules-4.2.0-01404-g5818d6e89783.log:real       7m0.507s
>   build-allmodules-4.2.0-01404-g5818d6e89783.log:real       7m1.551s
>   build-allmodules-4.2.0-01404-g5818d6e89783.log:real       6m59.073s
>   build-allmodules-4.2.0-01404-g5818d6e89783.log:real       7m1.738s
>
>   build-allmodules-4.2.0-01406-g638c69fddc40.log:real       7m10.644s
>   build-allmodules-4.2.0-01406-g638c69fddc40.log:real       6m59.814s
>   build-allmodules-4.2.0-01406-g638c69fddc40.log:real       7m0.315s
>   build-allmodules-4.2.0-01406-g638c69fddc40.log:real       6m59.610s
>   build-allmodules-4.2.0-01406-g638c69fddc40.log:real       6m59.885s
>   build-allmodules-4.2.0-01406-g638c69fddc40.log:real       6m59.281s
>   build-allmodules-4.2.0-01406-g638c69fddc40.log:real       7m0.869s
>   build-allmodules-4.2.0-01406-g638c69fddc40.log:real       7m0.953s
>   build-allmodules-4.2.0-01406-g638c69fddc40.log:real       7m0.787s
>   build-allmodules-4.2.0-01406-g638c69fddc40.log:real       7m0.656s
>
> I will check what kind of workloads this patch was written for.
> Tirumalesh, any idea?

mainly for workloads where compiler optimizes based on cache line size,
let me write a small bench mark
> Thanks,
>
> -Robert
>
>>> Increasing the size has no negative impact to cache invalidation on
>>> systems with a smaller cache line. There is an impact on memory usage,
>>> but that's not too important for arm64 use cases.
>> Do you have any before/after numbers to show the impact of this change
>> on other supported SoCs?
