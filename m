From: james.hogan@imgtec.com (James Hogan)
Date: Thu, 13 Jun 2013 15:31:51 +0100
Subject: [PATCH v4 3/5] clk: add support for clock reparent on set_rate
In-Reply-To: <519A92DC.2030208@codeaurora.org>
References: <1369056507-32521-1-git-send-email-james.hogan@imgtec.com>
 <1369056507-32521-4-git-send-email-james.hogan@imgtec.com>
 <519A92DC.2030208@codeaurora.org>
Message-ID: <51B9D7D7.3070103@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/05/13 22:17, Stephen Boyd wrote:
> On 05/20/13 06:28, James Hogan wrote:
>> diff --git a/Documentation/clk.txt b/Documentation/clk.txt
>> index b9911c2..3110ba4 100644
>> --- a/Documentation/clk.txt
>> +++ b/Documentation/clk.txt
>> @@ -70,6 +70,10 @@ the operations defined in clk.h:
>>  						unsigned long parent_rate);
>>  		long		(*round_rate)(struct clk_hw *hw, unsigned long,
>>  						unsigned long *);
>> +		long		(*determine_rate)(struct clk_hw *hw,
>> +						unsigned long rate,
>> +						unsigned long *best_parent_rate,
>> +						struct clk **best_parent_clk);
>>  		int		(*set_parent)(struct clk_hw *hw, u8 index);
>>  		u8		(*get_parent)(struct clk_hw *hw);
>>  		int		(*set_rate)(struct clk_hw *hw, unsigned long);
> 
> Can you update the clock hardware characteristics table as well?
> 

Yep, I'll add the hunk below to the patch in the next version.

Cheers
James

@@ -179,26 +183,28 @@ mandatory, a cell marked as "n" implies that either including that
 callback is invalid or otherwise unnecessary.  Empty cells are either
 optional or must be evaluated on a case-by-case basis.
 
-                           clock hardware characteristics
-	     -----------------------------------------------------------
-             | gate | change rate | single parent | multiplexer | root |
-             |------|-------------|---------------|-------------|------|
-.prepare     |      |             |               |             |      |
-.unprepare   |      |             |               |             |      |
-             |      |             |               |             |      |
-.enable      | y    |             |               |             |      |
-.disable     | y    |             |               |             |      |
-.is_enabled  | y    |             |               |             |      |
-             |      |             |               |             |      |
-.recalc_rate |      | y           |               |             |      |
-.round_rate  |      | y           |               |             |      |
-.set_rate    |      | y           |               |             |      |
-             |      |             |               |             |      |
-.set_parent  |      |             | n             | y           | n    |
-.get_parent  |      |             | n             | y           | n    |
-             |      |             |               |             |      |
-.init        |      |             |               |             |      |
-	     -----------------------------------------------------------
+                              clock hardware characteristics
+                -----------------------------------------------------------
+                | gate | change rate | single parent | multiplexer | root |
+                |------|-------------|---------------|-------------|------|
+.prepare        |      |             |               |             |      |
+.unprepare      |      |             |               |             |      |
+                |      |             |               |             |      |
+.enable         | y    |             |               |             |      |
+.disable        | y    |             |               |             |      |
+.is_enabled     | y    |             |               |             |      |
+                |      |             |               |             |      |
+.recalc_rate    |      | y           |               |             |      |
+.round_rate     |      | y [1]       |               |             |      |
+.determine_rate |      | y [1]       |               |             |      |
+.set_rate       |      | y           |               |             |      |
+                |      |             |               |             |      |
+.set_parent     |      |             | n             | y           | n    |
+.get_parent     |      |             | n             | y           | n    |
+                |      |             |               |             |      |
+.init           |      |             |               |             |      |
+                -----------------------------------------------------------
+[1] either one of round_rate or determine_rate is required.
 
 Finally, register your clock at run-time with a hardware-specific
 registration function.  This function simply populates struct clk_foo's
