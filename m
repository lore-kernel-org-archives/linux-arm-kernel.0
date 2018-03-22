From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Thu, 22 Mar 2018 16:43:28 +0000
Subject: [PATCH v4 19/22] arm64: capabilities: Handle shared entries
In-Reply-To: <20180313115120.17256-20-suzuki.poulose@arm.com>
References: <20180313115120.17256-1-suzuki.poulose@arm.com>
 <20180313115120.17256-20-suzuki.poulose@arm.com>
Message-ID: <6a7c55b2-a5a5-c672-1b85-5ba9c8e8560b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/03/18 11:51, Suzuki K Poulose wrote:
> Some capabilities have different criteria for detection and associated
> actions based on the matching criteria, even though they all share the
> same capability bit. So far we have used multiple entries with the same
> capability bit to handle this. This is prone to errors, as the
> cpu_enable is invoked for each entry, irrespective of whether the
> detection rule applies to the CPU or not. And also this complicates
> other helpers, e.g, __this_cpu_has_cap.
> 
> This patch adds a wrapper entry to cover all the possible variations
> of a capability by maintaining list of matches + cpu_enable callbacks.
> To avoid complicating the prototypes for the "matches()", we use
> arm64_cpu_capabilities maintain the list and we ignore all the other
> fields except the matches & cpu_enable.
> 
> This ensures :
> 
>   1) The capabilitiy is set when at least one of the entry detects
>   2) Action is only taken for the entries that "matches".
> 
> This avoids explicit checks in the cpu_enable() take some action.
> The only constraint here is that, all the entries should have the
> same "type" (i.e, scope and conflict rules).
> 
> If a cpu_enable() method is associated with multiple matches for a
> single capability, care should be taken that either the match criteria
> are mutually exclusive, or that the method is robust against being
> called multiple times.
> 
> This also reverts the changes introduced by commit 67948af41f2e6818ed
> ("arm64: capabilities: Handle duplicate entries for a capability").
> 
> Cc: Robin Murphy <robin.murphy@arm.com>
> Reviewed-by: Dave Martin <dave.martin@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Lost changelog:


Changes since v3
  - Rename cap_list => match_list
  - Address other comments from Dave
  - Added Reviewed-by from Dave

Cheers
Suzuki
