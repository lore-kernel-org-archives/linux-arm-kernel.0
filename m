From: elder@linaro.org (Alex Elder)
Date: Thu, 7 Jun 2018 05:12:51 -0500
Subject: [PATCH v5 2/4] kernel hacking: new config NO_AUTO_INLINE to
 disable compiler auto-inline optimizations
In-Reply-To: <20180607091923.n5q5uzsxuymy3vov@vireshk-i7>
References: <201806060501.btF3aJMZ%fengguang.wu@intel.com>
 <20180606095714.1d3c2def@vmware.local.home>
 <20180606142600.GN13775@localhost>
 <20180606142622.2338abf6@vmware.local.home>
 <20180607041718.qpqucjzlvcm5h3gn@vireshk-i7>
 <20180607074628.kd3iyxevwj3ypzbr@intel.com>
 <20180607083856.ealw62v3wx43zeqz@vireshk-i7>
 <1303b1abf9f9229a8d3ccbb68a3e413266b360d7.camel@petrovitsch.priv.at>
 <20180607091025.m7dfix3e2xbwx4cs@vireshk-i7>
 <20180607091816.GT13775@localhost>
 <20180607091923.n5q5uzsxuymy3vov@vireshk-i7>
Message-ID: <314bb2b3-186e-d7b0-d800-f77a42fd80fa@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/07/2018 04:19 AM, Viresh Kumar wrote:
> On 07-06-18, 11:18, Johan Hovold wrote:
>> If you want to work around the warning and think you can do it in some
>> non-contrived way, then go for it.
>>
>> Clearing the request buffer, checking for termination using strnlen, and
>> then using memcpy might not be too bad.
>>
>> But after all, it is a false positive, so leaving things as they stand
>> is fine too.
> 
> Leave it then :)
> 

It's interesting that the warning isn't reported for this in
fw_mgmt_interface_fw_version_operation().  The difference there is
that you actually put a zero byte at that last position before
returning.  I'm mildly impressed if gcc is distinguishing that.

You *are* returning the fw_info->firmware_tag array newly filled
with a non-null-terminated string in one of the two cases that
get warnings in "fw-management.c".  But the other one is only
updating a buffer in a local/automatic variable.

Weird.  I wish there were a non-clumsy way of marking false positives
like this as A-OK.

					-Alex
