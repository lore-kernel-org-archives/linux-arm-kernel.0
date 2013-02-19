From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 19 Feb 2013 10:18:13 -0700
Subject: [RFC 1/2] Makefile: Add arch/arch/$(hdr-arch)/boot in header
 include path
In-Reply-To: <51222BF9.3040802@suse.cz>
References: <1360918364-27960-1-git-send-email-hdoyu@nvidia.com>
 <511E617E.6080206@wwwdotorg.org> <51222BF9.3040802@suse.cz>
Message-ID: <5123B3D5.1000405@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/18/2013 06:26 AM, Michal Marek wrote:
> On 15.2.2013 17:25, Stephen Warren wrote:
>> On 02/15/2013 01:52 AM, Hiroshi Doyu wrote:
>>> This patch allows kernel source to include those DT
>>> headers. For example:
>>>
>>> + #include <dts/tegra20-car.h>
>>>
>>> Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
>>> ---
>>>  Makefile |    2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/Makefile b/Makefile
>>> index 0b4bf62..7f54cdb 100644
>>> --- a/Makefile
>>> +++ b/Makefile
>>> @@ -364,7 +364,7 @@ LINUXINCLUDE    := \
>>>  		-I$(srctree)/arch/$(hdr-arch)/include \
>>>  		-Iarch/$(hdr-arch)/include/generated \
>>>  		$(if $(KBUILD_SRC), -I$(srctree)/include) \
>>> -		-Iinclude \
>>> +		-Iinclude -Iarch/$(hdr-arch)/boot \
> 
> Would it be possible to use a new directory for this? At least POWER and
> x86 have several unrelated headers in their arch/*/boot that are only
> meant for the bootstrap code.

The need here is to allow access to headers in
arch/$(hdr-arch)/boot/dts, but passing the directory above that allows
including files as <dts/foo.h> which is nice. That's the rationale for
this patch.

But as I mentioned in other threads, I wonder if we should put the
header files in arch/$(hdr-arch)/boot/dts at all;
Documentation/devicetree/bindings/... would keep the headers adjacent to
the documentation for the bindings themselves, and the headers really
are part of the binding definitions... That would avoid the issue Michal
pointed out, and I think clean up the dtc+cpp include path usage too.

Grant, what are your thoughts?
